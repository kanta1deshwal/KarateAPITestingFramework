Feature: Validate API Status Codes with Headers and Parameters

  Background:
    * def env = karate.env ? karate.env : 'prod'
    * def config = call read('classpath:status-config.js')
    * url config.baseUrl
  #  * configure headers = config.headers
   # * header Accept = config.headers.Accept
   
 #   * header Content-Type = config.headers['Content-Type']

  Scenario Outline: Validate API <endpoint> Response
   * def endpoint = '<endpoint>'
  * configure headers = config.headers(endpoint)
    Given path endpoint
 * def requestParams = config.apiParams['<endpoint>']
  * def isNotEmpty = requestParams != null && karate.sizeOf(requestParams) > 0
  * print 'Params to send:', requestParams
   * def paramsToSend = {} 
   * if (isNotEmpty) karate.set('paramsToSend', requestParams)

 * params paramsToSend
   

   
  
  

 
  
    When method GET
    Then status 200
    * print 'Endpoint:', endpoint
    * print 'Response Snippet:', response 

  Examples:
    | endpoint |
    | /api/user/community.web.details |
    | /timeline-api/timeline/get-timeline |
    | /api/profile/detail |
    | /api/user/get-left-menu |
    | /chat-api/room  |
    | /api/helps    |
    | /api/events  |
    | /api/success-stories/list |
    | /api/knowyourcommunity/detail |
    | /api/gallery |
    | /associate-partner-api/business-category/list  |
    | /api/friends/all-friends |
    | /user-api/v1/communty-dazzling-star |
    | /timeline-api/saved-post/list  |
    | /user-api/v1/user-notification-settings |
    | /api/friends/blocked  |
    | /api/v2/likes/getLikes |
    | api/likes/reaction-count |
    | /api/v2/comments/getComments |
    
