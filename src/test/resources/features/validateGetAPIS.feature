Feature: Validate All GET APIs with Dynamic Params & Database

Background:
    * def env = karate.env ? karate.env : 'prod'
    * def config = call read('classpath:karate-config.js')
    
    * print 'Running in environment:', env
    * url config.baseUrl
    * configure headers = config.headers  
    * print 'Using Base URL:', config.baseUrl
    * print 'Using Authorization Token:', config.headers.Authorization
    * print 'platform:', config.platform

    # Initialize Database Utility
    * def DataBaseUtils = Java.type('com.matpatra.utils.DataBaseUtils')
    * def db = new DataBaseUtils()

    # Define validation function for timeline API posts
    * def validatePost =
    """
    function(apiPost) {
        if (!apiPost || !apiPost.id) {
            karate.fail('Invalid API response: Post ID is missing');
        }

        var postId = parseInt(apiPost.id);
        karate.log("Validating Post ID:", postId);

        var query = "SELECT * FROM forum_posts WHERE id = " + postId;
        var dbPostList = db.executeQuery(query);

        if (!dbPostList || dbPostList.length === 0) {
            karate.fail('No matching DB record found for post ID: ' + postId);
        }

        var dbPost = dbPostList[0];
        karate.log("DB Data for Post ID:", postId, karate.pretty(dbPost));
        

        // Convert DB post ID to match API response data type
        dbPost.id = postId.toString(); 

        // Validate API response with DB
        return karate.match(apiPost, dbPost);
    }
    """
    
     * def validateProfileApi =
    """
    function(apiResponse) {
    karate.log("Function is being executed!");
        var id = karate.get('params.id'); // User ID from params
        if (!id) {
            karate.fail('User ID is missing from request params');
        }

        var profileQuery = "SELECT * FROM users WHERE id = " + id;
        
        karate.log("Executing SQL Query:", profileQuery);
        var dbProfileList = db.executeQuery(profileQuery);
        
          karate.log("Database result:", dbProfileList);


        if (!dbProfileList || dbProfileList.length === 0) {
            karate.fail('No matching data found in DB for user ID: ' + id);
        }

        var dbProfile = dbProfileList[0];
       
        

     
        if (!apiResponse.data) {
            karate.fail('Profile API response is missing "data" key');
        }

        return karate.match(apiResponse.data, dbProfile);
    }
    """
    

Scenario Outline: Validate API <endpoint> Response
    Given url config.baseUrl + '<endpoint>'

    # Initialize dynamic params from the examples table (only once)
    * def params = {}

    # Check if it's the 'profile' API, and only add 'id' from config if required
    * if (apiName == 'profile') params.id = config.id
        

    # For 'timeline' API, add 'limit' and 'skip' from examples if they are not empty
 * if (apiName == 'timeline') params.limit = limit, params.skip = skip
        
        

    # Print params before merging (for debugging)
    * print 'Params before merging:', params

    # Retrieve the parameters for the given API from the config.js (e.g., profile API might need id)
    * def dynamicParams = config.setParams(apiName, params)
    * print 'Type of dynamicParams:', karate.typeOf(dynamicParams)
    

    # Print merged params after dynamicParams are applied (for debugging)
    * print 'Merged Params:', dynamicParams
    

    # Filter out empty or null values from merged parameters (for cleanup)
    * eval Object.keys(dynamicParams).forEach(key => print ('Key:', key, 'Value:', dynamicParams[key]))


 * params dynamicParams
   
    
    When method GET
    Then status 200
    * def apiResponse = response
    * print 'API Response:', apiResponse

    # Ensure API response contains data
    * if (!apiResponse || !apiResponse.data) karate.fail('API response is missing data')

    # Fetch corresponding table from DB dynamically
    * def endpointToTableMap =
    """
    {
        "/timeline-api/timeline/get-timeline": "forum_posts",
        "/api/profile/detail": "users"
    }
    """
    * def tableName = endpointToTableMap[endpoint]
    * if (!tableName) karate.fail('No table mapping found for endpoint: ' + endpoint)
    * print 'Checking data in table:', tableName

    # Validate Timeline API
    * def isTimelineApi = endpoint == '/timeline-api/timeline/get-timeline'
    * if (isTimelineApi) karate.forEach(apiResponse.data, validatePost)

    # Validate Profile API
    * def isProfileApi = endpoint == '/api/profile/detail'
    * print 'isProfileApi value:', isProfileApi
    
       
* def validationResult = null
* if (isProfileApi) validationResult = validateProfileApi(apiResponse)
* print 'Validation Result:', validationResult




Examples:
    | endpoint                                  | apiName  | limit | skip |
    | /timeline-api/timeline/get-timeline         | timeline | 10    | 0    |
    | /timeline-api/timeline/get-timeline         | timeline | 10    | 10   |
    | /api/profile/detail                        | profile  |       |      |
