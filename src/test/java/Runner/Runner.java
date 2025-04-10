package Runner;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;

import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.stream.Stream;

public class Runner {

    static String timestampDir;

    @BeforeAll
    static void beforeAll() {
        System.setProperty("karate.env", "production");

        // Generate timestamp folder name
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss");
        timestampDir = "target/karate-reports-" + LocalDateTime.now().format(formatter);
    }

    @Karate.Test
    Karate runTests() {
        return Karate.run("classpath:features/validateAPIStatusCode.feature").relativeTo(getClass());
    }

    @AfterAll
    static void afterAll() throws IOException {
        // 1. Source of the Karate reports (default location where Karate stores reports)
        Path source = Paths.get("target/karate-reports");

        // 2. If source doesn't exist, exit early
        if (!Files.exists(source)) {
            System.out.println("⚠️ No report found to copy.");
            return;
        }

        // 3. Create a timestamped folder for the copied report
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss"));
        Path target = Paths.get("target", "karate-summary-" + timestamp);

        // 4. Ensure the target directory is created before copying starts
        Files.createDirectories(target);

        // 5. Walk through all files and folders in the source directory
        try (Stream<Path> stream = Files.walk(source)) {
            stream.forEach(src -> {
                try {
                    // 6. Create destination path relative to the target
                    Path resolvedPath = target.resolve(source.relativize(src));

                    // 7. Prevent accidental recursive copy into itself (edge safety)
                    if (!resolvedPath.normalize().startsWith(target.normalize())) return;

                    // 8. Copy directories and files accordingly
                    if (Files.isDirectory(src)) {
                        Files.createDirectories(resolvedPath);
                    } else {
                        Files.copy(src, resolvedPath, StandardCopyOption.REPLACE_EXISTING);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
        }

        // 9. Log confirmation
        System.out.println("✅ Karate report copied to: " + target.toAbsolutePath());
        System.out.println("🎉 All tests completed. Shutting down.");

        // 10. Forcefully stop JVM (optional – use only during debugging)
        System.exit(0);
    }
}