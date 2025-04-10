function fn() {
    var config = {};

	var env = karate.env || 'staging'; 
	
	// Set base URLs for different environments
	    if (env === 'staging') {
	        config.baseUrl = 'https://stage-community-api.matpatra.com';
	       
	        
	    } else if (env === 'production') {
	        config.baseUrl = 'https://community-api.matpatra.com';
	       }
		
		   config.apiToken  = 'mAtPatranodehGoEg1bmDHx0dE3tbtx6HKIWHlcCOD29NfKn5F3erWmATfXW7KbJX6b2MZtPfx2a';
		   config.authToken = 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjM4NywiZmlyc3RfbmFtZSI6IlNhbnZpIiwibWlkZGxlX25hbWUiOiJEZXNod2FsIiwibGFzdF9uYW1lIjoiIiwiZmF0aGVyX25hbWUiOm51bGwsIm1vYmlsZV9hbHQiOjcwMjc0NDAwOTAsInVzZXJuYW1lIjpudWxsLCJkb2IiOiIyMDA2LTAxLTA5IiwiZ2VuZGVyIjoiRmVtYWxlIiwibW9iaWxlX3ByaW1hcnkiOiI3MDI3NDQwMDkwIiwibW9iaWxlX3dhIjpudWxsLCJtb2JpbGVfb2ZmaWNlMSI6bnVsbCwicGhvbmUxIjpudWxsLCJwaG9uZTIiOm51bGwsImVtYWlsIjoiIiwicGFzc3dvcmQiOiI1OTEzMTdjYzk0YTdiNmM4NWM3N2ViYjU4ZDg3ZWU3MCIsInVzZXJfcHJvZmlsZV9waWMiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8yNi0xMi0yMDI0LzY3NmNlM2JhOTEyZjEtMTczNTE4OTQzNC1TYW52aS1JbmRpYS1wcm9maWxlLmpwZyIsInVzZXJfY292ZXJfaW1hZ2UiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8xMi0xMi0yMDI0LzY3NWFiODJkN2I2YzUtMTczMzk5ODYzNy1TYW52aS1JbmRpYS1wcm9maWxlLnBuZyIsInF1YWxpZmljYXRpb25faWQiOm51bGwsImVkdWNhdGlvbl9pZCI6bnVsbCwib2NjdXBhdGlvbl9pZCI6bnVsbCwicHJvZmVzc2lvbl9pZCI6bnVsbCwidXNlcl9hZGRyZXNzIjpudWxsLCJhZGRyZXNzX3BpbmNvZGUiOjExMDA0MSwiYWRkcmVzc19zdGF0ZV9pZCI6NCwiYWRkcmVzc19jaXR5X2lkIjpudWxsLCJlbGN0X3BjX2lkIjozMCwiZWxjdF9zdGF0ZV9pZCI6MywiZWxjdF9hY19pZCI6bnVsbCwiZWxjdF93YXJkX2lkIjpudWxsLCJlbGN0X3BiX2lkIjpudWxsLCJsYW5nX2lkIjo0NywicmVsaWdpb25faWQiOm51bGwsImNhc3RlX2lkIjpudWxsLCJpc192b2x1bnRlZXIiOjAsInVzZXJfYm9vdGhfd29ya2VyX2lkIjoyNjAsImlzX2xlYWRlciI6MCwiZW1haWxfdmVyaWZpZWQiOjAsImlzX29uYm9hcmRlZCI6MSwic29jaWFsX2xvZ2luX21ldGhvZCI6bnVsbCwib25saW5lX2xhbmdfaWQiOjQ3LCJzb2NpYWxfbWV0aG9kIjpudWxsLCJzb2NpYWxfZGF0YSI6bnVsbCwiYWNjb3VudF9zdGF0dXMiOjEsInJlbWFya3MiOm51bGwsImlzX2xvZ291dCI6MCwidXBkYXRlZF9hdCI6IjIwMjUtMDMtMTdUMTE6MzE6NTguMDAwWiIsImNyZWF0ZWRfYXQiOiIyMDI0LTAyLTEyVDEwOjU4OjMwLjAwMFoiLCJiaW8iOiJUZXN0IiwiY29sb3VyIjoiIzM2MzUzMyIsImlzX290cF92ZXJpZmllZCI6MCwiaXNfY2VsZWJyaXR5IjowLCJpYXQiOjE3NDI3OTYzOTZ9.3YfkzXRTIpGzmU-Nyjjri1CkoVsV8PUBaYGFx9hr0sSSFR0zoRr4ftDWysVAKFEINQwI6LbEwAgvLu-6nxarCA';
           config.accept = 'application/json';
		   config.contentType = 'application/json';
		   config.leaderId = '25';
		   
    // Common Headers
   // config.headers = {
       // Authorization : 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjM4NywiZmlyc3RfbmFtZSI6IlNhbnZpIiwibWlkZGxlX25hbWUiOiJEZXNod2FsIiwibGFzdF9uYW1lIjoiIiwiZmF0aGVyX25hbWUiOm51bGwsIm1vYmlsZV9hbHQiOjcwMjc0NDAwOTAsInVzZXJuYW1lIjpudWxsLCJkb2IiOiIyMDA2LTAxLTA5IiwiZ2VuZGVyIjoiRmVtYWxlIiwibW9iaWxlX3ByaW1hcnkiOiI3MDI3NDQwMDkwIiwibW9iaWxlX3dhIjpudWxsLCJtb2JpbGVfb2ZmaWNlMSI6bnVsbCwicGhvbmUxIjpudWxsLCJwaG9uZTIiOm51bGwsImVtYWlsIjoiIiwicGFzc3dvcmQiOiI1OTEzMTdjYzk0YTdiNmM4NWM3N2ViYjU4ZDg3ZWU3MCIsInVzZXJfcHJvZmlsZV9waWMiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8yNi0xMi0yMDI0LzY3NmNlM2JhOTEyZjEtMTczNTE4OTQzNC1TYW52aS1JbmRpYS1wcm9maWxlLmpwZyIsInVzZXJfY292ZXJfaW1hZ2UiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8xMi0xMi0yMDI0LzY3NWFiODJkN2I2YzUtMTczMzk5ODYzNy1TYW52aS1JbmRpYS1wcm9maWxlLnBuZyIsInF1YWxpZmljYXRpb25faWQiOm51bGwsImVkdWNhdGlvbl9pZCI6bnVsbCwib2NjdXBhdGlvbl9pZCI6bnVsbCwicHJvZmVzc2lvbl9pZCI6bnVsbCwidXNlcl9hZGRyZXNzIjpudWxsLCJhZGRyZXNzX3BpbmNvZGUiOjExMDA0MSwiYWRkcmVzc19zdGF0ZV9pZCI6NCwiYWRkcmVzc19jaXR5X2lkIjpudWxsLCJlbGN0X3BjX2lkIjozMCwiZWxjdF9zdGF0ZV9pZCI6MywiZWxjdF9hY19pZCI6bnVsbCwiZWxjdF93YXJkX2lkIjpudWxsLCJlbGN0X3BiX2lkIjpudWxsLCJsYW5nX2lkIjo0NywicmVsaWdpb25faWQiOm51bGwsImNhc3RlX2lkIjpudWxsLCJpc192b2x1bnRlZXIiOjAsInVzZXJfYm9vdGhfd29ya2VyX2lkIjoyNjAsImlzX2xlYWRlciI6MCwiZW1haWxfdmVyaWZpZWQiOjAsImlzX29uYm9hcmRlZCI6MSwic29jaWFsX2xvZ2luX21ldGhvZCI6bnVsbCwib25saW5lX2xhbmdfaWQiOjQ3LCJzb2NpYWxfbWV0aG9kIjpudWxsLCJzb2NpYWxfZGF0YSI6bnVsbCwiYWNjb3VudF9zdGF0dXMiOjEsInJlbWFya3MiOm51bGwsImlzX2xvZ291dCI6MCwidXBkYXRlZF9hdCI6IjIwMjUtMDMtMTdUMTE6MzE6NTguMDAwWiIsImNyZWF0ZWRfYXQiOiIyMDI0LTAyLTEyVDEwOjU4OjMwLjAwMFoiLCJiaW8iOiJUZXN0IiwiY29sb3VyIjoiIzM2MzUzMyIsImlzX290cF92ZXJpZmllZCI6MCwiaXNfY2VsZWJyaXR5IjowLCJpYXQiOjE3NDI3OTYzOTZ9.3YfkzXRTIpGzmU-Nyjjri1CkoVsV8PUBaYGFx9hr0sSSFR0zoRr4ftDWysVAKFEINQwI6LbEwAgvLu-6nxarCA',
	   
	//   Authorization : config.authToken,
    //    Accept: config.accept,
	//	'Leader-Id' : config.leaderId,
    //    'Content-Type': config.contentType
  //  };
  
  config.headers = function(endpoint) {
          const headers = {
              Accept: config.accept,
              'Content-Type': config.contentType,
              'Leader-Id': config.leaderId
          };

          if (endpoint === "/api/user/community.web.details") {
              headers["Api-Token"] = config.apiToken; // API Token
          } else {
              headers.Authorization = config.authToken; // Auth Token
          }

          return headers;
      };

    // API-specific parameters (Modify as per your API)
    config.apiParams = {
        "/api/user/community.web.details": {user_name: "lcc" },
        "/timeline-api/timeline/get-timeline": {limit: "10", skip: "0"},
        "/api/profile/detail": {id: "2387"},
        "/api/user/get-left-menu": {},
		"/chat-api/room": {},
		"/api/helps": {filterBy: "0" , limit: "10", skip: "0"},
		"/api/events": {page: "1" , limit: "10", skip: "0" , filterBy: "1" },
		"/api/success-stories/list": {filterBy: "0" , limit: "10", skip: "0"},
		"/api/knowyourcommunity/detail": {},
		"/api/gallery": {filterBy: "2" , content_type: "image" , page: "1"},
		"/associate-partner-api/business-category/list": {limit: "10"},
		"/api/friends/all-friends": {page: "1" , limit: "20" },
		"/user-api/v1/communty-dazzling-star": {},
		"/timeline-api/saved-post/list": {page: "1" , limit: "10", skip: "0" },
		"/user-api/v1/user-notification-settings": {},
		"/api/friends/blocked": {page: "1"},
		"/api/v2/likes/getLikes": {asset_id: "1", asset_type_id: "16786" , limit: "10", skip: "0" },
		"api/likes/reaction-count": {asset_id: "1", asset_type_id: "16786"},
		"/api/v2/comments/getComments": {asset_id: "1", asset_type_id: "16786" , limit: "10", skip: "0" }
        
    };

	
    return config;
	throw new Error('karate-config.js file is being used');
}
