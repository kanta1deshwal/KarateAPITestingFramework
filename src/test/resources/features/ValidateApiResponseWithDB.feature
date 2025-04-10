Feature: Validate API Response with Database:
Background:
    * url 'https://community-api.matpatra.com'
   * configure ssl = true
 * def db = Java.type('com.matpatra.utils.DataBaseUtils')

      * def dbInstance = new com.matpatra.utils.DataBaseUtils()
    * def executeQuery = function(query) { return dbInstance.executeQuery(query); }
   
    * def requestHeaders = 
    """
    { "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpZCI6MjM4NywiZmlyc3RfbmFtZSI6IlNhbnZpIiwibWlkZGxlX25hbWUiOiJEZXNod2FsIiwibGFzdF9uYW1lIjoiIiwiZmF0aGVyX25hbWUiOm51bGwsIm1vYmlsZV9hbHQiOm51bGwsInVzZXJuYW1lIjpudWxsLCJkb2IiOiIyMDA2LTAxLTA5IiwiZ2VuZGVyIjoiRmVtYWxlIiwibW9iaWxlX3ByaW1hcnkiOiI3MDI3NDQwMDkwIiwibW9iaWxlX3dhIjpudWxsLCJtb2JpbGVfb2ZmaWNlMSI6bnVsbCwicGhvbmUxIjpudWxsLCJwaG9uZTIiOm51bGwsImVtYWlsIjoiIiwicGFzc3dvcmQiOiI1OTEzMTdjYzk0YTdiNmM4NWM3N2ViYjU4ZDg3ZWU3MCIsInVzZXJfcHJvZmlsZV9waWMiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8yNi0xMi0yMDI0LzY3NmNlM2JhOTEyZjEtMTczNTE4OTQzNC1TYW52aS1JbmRpYS1wcm9maWxlLmpwZyIsInVzZXJfY292ZXJfaW1hZ2UiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8xMi0xMi0yMDI0LzY3NWFiODJkN2I2YzUtMTczMzk5ODYzNy1TYW52aS1JbmRpYS1wcm9maWxlLnBuZyIsInF1YWxpZmljYXRpb25faWQiOm51bGwsImVkdWNhdGlvbl9pZCI6bnVsbCwib2NjdXBhdGlvbl9pZCI6bnVsbCwicHJvZmVzc2lvbl9pZCI6bnVsbCwidXNlcl9hZGRyZXNzIjpudWxsLCJhZGRyZXNzX3BpbmNvZGUiOjExMDA0MSwiYWRkcmVzc19zdGF0ZV9pZCI6NCwiYWRkcmVzc19jaXR5X2lkIjpudWxsLCJlbGN0X3BjX2lkIjozMCwiZWxjdF9zdGF0ZV9pZCI6MywiZWxjdF9hY19pZCI6bnVsbCwiZWxjdF93YXJkX2lkIjpudWxsLCJlbGN0X3BiX2lkIjpudWxsLCJsYW5nX2lkIjo0NywicmVsaWdpb25faWQiOm51bGwsImNhc3RlX2lkIjpudWxsLCJpc192b2x1bnRlZXIiOjAsInVzZXJfYm9vdGhfd29ya2VyX2lkIjoyNjAsImlzX2xlYWRlciI6MCwiZW1haWxfdmVyaWZpZWQiOjAsImlzX29uYm9hcmRlZCI6ZmFsc2UsInNvY2lhbF9sb2dpbl9tZXRob2QiOm51bGwsIm9ubGluZV9sYW5nX2lkIjo0NywiYWNjb3VudF9zdGF0dXMiOjEsInNvY2lhbF9tZXRob2QiOm51bGwsInNvY2lhbF9kYXRhIjpudWxsLCJyZW1hcmtzIjpudWxsLCJiaW8iOiJUZXN0IiwiY29sb3VyIjoiIzM2MzUzMyIsImlzX290cF92ZXJpZmllZCI6MCwiaXNfY2VsZWJyaXR5IjowLCJjcmVhdGVkX2F0IjoiMjAyNC0wMi0xMlQxMDo1ODozMC4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjUtMDItMTJUMTE6NDE6MzEuMDAwWiJ9.lH9jxRhLFi4ualQ7GnG_t9m7PUE5Zrvc0Y0e909Jpj_ip9HNvmY-X-5gvgh6wipw8AeDZTq6TYJToAzsXXH2FQ", "Leader-Id" : 25} 
    
   """ 

  Scenario: Validate API posts with DB records
    # Define request parameters
    * def requestParams = { limit: 10, skip: 0 }
    * print "Manually Stored Request Params:", requestParams

    Given path 'timeline-api/timeline/get-timeline'
    And headers requestHeaders
    And params requestParams
    When method GET
    Then status 200

    * print "Leader-Id:", requestHeaders["Leader-Id"]
    * print "Response Status Code:", responseStatus
    
    * def apiPosts = response.data

   * print "API Posts:", apiPosts
   * karate.log("Total API Posts:", apiPosts.length)
   
   

   

  # Define validation function
* def validatePost =
"""
function(apiPost) {
 karate.log("validatePost function is being executed for Post ID:", apiPost.id);
    var postId = apiPost.id;
    karate.log("API Data for Post ID:", postId, karate.pretty(apiPost));
    
    var query = "SELECT * FROM forum_posts WHERE id = " + postId;
    var dbPostList = executeQuery(query);

    if (!dbPostList || dbPostList.length === 0) {
        karate.fail('No matching DB record found for post ID: ' + postId);
    }

    var dbPost = dbPostList[0]; // Assuming one matching record
    
    // Logging DB data
    karate.log("DB Data for Post ID:", postId, karate.pretty(dbPost));


    // Validate fields

    karate.match(apiPost.user_id, dbPost.user_id);
    karate.match(apiPost.leader_id, dbPost.leader_id);
    karate.match(apiPost.asset_id, dbPost.asset_id);
    karate.match(apiPost.asset_type_id, dbPost.asset_type_id);
    karate.match(apiPost.description, dbPost.description);
    karate.match(apiPost.post_views, dbPost.post_views);
    karate.match(apiPost.post_likes, dbPost.post_likes);
    karate.match(apiPost.post_comments, dbPost.post_comments);
    karate.match(apiPost.post_shares, dbPost.post_shares);
    karate.match(apiPost.reposts, dbPost.reposts);
    karate.match(apiPost.comment_status, dbPost.comment_status);
    karate.match(apiPost.publish_date, dbPost.publish_date);
    karate.match(apiPost.created_at, dbPost.created_at);
    karate.match(apiPost.updated_at, dbPost.updated_at);
    karate.match(apiPost.deleted_at, dbPost.deleted_at);
    karate.match(apiPost.status, dbPost.status);
    karate.match(apiPost.publish_status, dbPost.publish_status);
    karate.match(apiPost.type, dbPost.type);
    karate.match(apiPost.constituency_id, dbPost.constituency_id);
    karate.match(apiPost.meta_property, dbPost.meta_property);
    karate.match(apiPost.post_unique_id, dbPost.post_unique_id);
    karate.match(apiPost.account_type, dbPost.account_type);
    karate.match(apiPost.tag_count, dbPost.tag_count);

    return true;
}
"""

* if (apiPosts != null && apiPosts.length > 0) karate.forEach(apiPosts, validatePost)
