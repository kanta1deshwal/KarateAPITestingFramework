 Feature: API Tests for Creating and Retrieving Data
 
  Background:
    * url 'https://community-api.matpatra.com'
   * configure ssl = true
    * def requestHeaders = 
    """
    { "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpZCI6MjM4NywiZmlyc3RfbmFtZSI6IlNhbnZpIiwibWlkZGxlX25hbWUiOiJEZXNod2FsIiwibGFzdF9uYW1lIjoiIiwiZmF0aGVyX25hbWUiOm51bGwsIm1vYmlsZV9hbHQiOm51bGwsInVzZXJuYW1lIjpudWxsLCJkb2IiOiIyMDA2LTAxLTA5IiwiZ2VuZGVyIjoiRmVtYWxlIiwibW9iaWxlX3ByaW1hcnkiOiI3MDI3NDQwMDkwIiwibW9iaWxlX3dhIjpudWxsLCJtb2JpbGVfb2ZmaWNlMSI6bnVsbCwicGhvbmUxIjpudWxsLCJwaG9uZTIiOm51bGwsImVtYWlsIjoiIiwicGFzc3dvcmQiOiI1OTEzMTdjYzk0YTdiNmM4NWM3N2ViYjU4ZDg3ZWU3MCIsInVzZXJfcHJvZmlsZV9waWMiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8yNi0xMi0yMDI0LzY3NmNlM2JhOTEyZjEtMTczNTE4OTQzNC1TYW52aS1JbmRpYS1wcm9maWxlLmpwZyIsInVzZXJfY292ZXJfaW1hZ2UiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8xMi0xMi0yMDI0LzY3NWFiODJkN2I2YzUtMTczMzk5ODYzNy1TYW52aS1JbmRpYS1wcm9maWxlLnBuZyIsInF1YWxpZmljYXRpb25faWQiOm51bGwsImVkdWNhdGlvbl9pZCI6bnVsbCwib2NjdXBhdGlvbl9pZCI6bnVsbCwicHJvZmVzc2lvbl9pZCI6bnVsbCwidXNlcl9hZGRyZXNzIjpudWxsLCJhZGRyZXNzX3BpbmNvZGUiOjExMDA0MSwiYWRkcmVzc19zdGF0ZV9pZCI6NCwiYWRkcmVzc19jaXR5X2lkIjpudWxsLCJlbGN0X3BjX2lkIjozMCwiZWxjdF9zdGF0ZV9pZCI6MywiZWxjdF9hY19pZCI6bnVsbCwiZWxjdF93YXJkX2lkIjpudWxsLCJlbGN0X3BiX2lkIjpudWxsLCJsYW5nX2lkIjo0NywicmVsaWdpb25faWQiOm51bGwsImNhc3RlX2lkIjpudWxsLCJpc192b2x1bnRlZXIiOjAsInVzZXJfYm9vdGhfd29ya2VyX2lkIjoyNjAsImlzX2xlYWRlciI6MCwiZW1haWxfdmVyaWZpZWQiOjAsImlzX29uYm9hcmRlZCI6ZmFsc2UsInNvY2lhbF9sb2dpbl9tZXRob2QiOm51bGwsIm9ubGluZV9sYW5nX2lkIjo0NywiYWNjb3VudF9zdGF0dXMiOjEsInNvY2lhbF9tZXRob2QiOm51bGwsInNvY2lhbF9kYXRhIjpudWxsLCJyZW1hcmtzIjpudWxsLCJiaW8iOiJUZXN0IiwiY29sb3VyIjoiIzM2MzUzMyIsImlzX290cF92ZXJpZmllZCI6MCwiaXNfY2VsZWJyaXR5IjowLCJjcmVhdGVkX2F0IjoiMjAyNC0wMi0xMlQxMDo1ODozMC4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjUtMDItMTJUMTE6NDE6MzEuMDAwWiJ9.lH9jxRhLFi4ualQ7GnG_t9m7PUE5Zrvc0Y0e909Jpj_ip9HNvmY-X-5gvgh6wipw8AeDZTq6TYJToAzsXXH2FQ", "Leader-Id" : 25} 
    
   """ 
Scenario: Retrieving first 10 timeline posts
  
* def requestParams = { limit: 10, skip: 0 }
* print "Manually Stored Request Params:", requestParams

Given path 'timeline-api/timeline/get-timeline'
And headers requestHeaders
And params requestParams
When method GET
Then status 200

    * print "Leader-Id:", requestHeaders["Leader-Id"]
    
    * print "Response Status Code:", responseStatus
    * print "Full Response:", response

    # Validate response contains exactly 'limit' elements
    * def keyCount = karate.sizeOf(response.data)
    
  * def paramLimitFromRequest = requestParams.limit

  * eval
    """
    if (keyCount == parseInt(paramLimitFromRequest)) {
        print (" Total elements in response.data matches param limit:", keyCount);
    } else {
        karate.fail("Total elements in response.data doesn't match param limit! Expected: " + paramLimitFromRequest + ", Found: " + keyCount);
    }
    """

    # Extract all IDs and check uniqueness
    * def idList = response.data.map(x => x.id)
    * def uniqueIds = karate.distinct(idList)
    * print "Extracted IDs:", idList
    * print "Unique IDs:", uniqueIds

    * eval
    """
    if (karate.sizeOf(idList) == karate.sizeOf(uniqueIds)) {
        print ("All IDs are unique!");
    } else {
        karate.fail("Duplicate IDs found in response: " + idList);
    }
    """

    # Retrieve Leader-Id from request header dynamically
    * def leaderIdHeader = requestHeaders["Leader-Id"]
    * print "Leader ID from Header:", leaderIdHeader

    # Validate all Leader-Id in response matches the one in the header
    * def leaderIdsFromResponse = response.data.map(x => x.leader_id)
    * print "Leader IDs in response:", leaderIdsFromResponse

    * def allMatch = leaderIdsFromResponse.every(x => x == leaderIdHeader)

    
    * eval
    """
    if (allMatch) {
        print (" All posts belong to Leader ID:", leaderIdHeader);
    } else {
        karate.fail("Some posts have a different Leader ID. Expected: " + leaderIdHeader + ", Found: " + leaderIdsFromResponse);
    }
    """
    
      Scenario: Retrieving next 20 data of timeline successfully
    Given path 'timeline-api/timeline/get-timeline'
    And headers requestHeaders
    And param limit = '20'
    And param skip = '10'
    When method GET  # Ensure API expects GET
    Then status 200
    And print "response status code is- " + responseStatus
    * print 'Response:', response
    * print "Leader Id:", requestHeaders["Leader-Id"]
    

 

 # Scenario: Create a new timeline entry using JSON data (POST)
 #   Given path 'timeline-api/timeline/create'
 #  * def requestBody = { description: "This is a static description"}
  # And request requestBody
 #   And header Accept = '*/*'
 #   And header content-type = 'application/json'
  #  And header accept-encoding = 'gzip,deflate,br,zstd'
  #  And header Connection = 'keep-alive'
  #  And header accept-language = 'en-US,en;q=0.9'
 #   When method POST
 #   Then status 200
 #  And print "response status code is- " + responseStatus
 #   * print 'Response:', response
 #   * print 'Request Body:', requestBody
    
#     Scenario: Retrieving chat data successfully
#    Given path 'chat-api/room'
#    When method GET  # Ensure API expects GET
#    Then status 200
 #   And print "response status code is- " + responseStatus
#    * print 'Response:', response
    