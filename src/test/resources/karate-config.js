function fn() {
    var env = karate.env || 'staging'; // Default to 'staging' if no env is provided
    var config = {};

    // Set base URLs for different environments
    if (env === 'staging') {
        config.baseUrl = 'https://stage-community-api.matpatra.com';
        config.dbConfig = {
            url: 'jdbc:mysql://stagedb.matpatra.in:3306/matpatra_community_25',
            username: 'matpatra_mla_api_user_rw',
            password: 'Matpatra@2019'
        };
    } else if (env === 'production') {
        config.baseUrl = 'https://community-api.matpatra.com';
        config.dbConfig = {
            url: 'jdbc:mysql://prod-db.cluster-cc2yfbof97l8.ap-south-1.rds.amazonaws.com:3306/matpatra_community_25',
            username: 'admin',
            password: 'NavNirmanGgn#2019'
        };
    }

    // Authorization Token & Leader ID
    config.authToken = 	'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjM4NywiZmlyc3RfbmFtZSI6IlNhbnZpIiwibWlkZGxlX25hbWUiOiJEZXNod2FsIiwibGFzdF9uYW1lIjoiIiwiZmF0aGVyX25hbWUiOm51bGwsIm1vYmlsZV9hbHQiOjcwMjc0NDAwOTAsInVzZXJuYW1lIjpudWxsLCJkb2IiOiIyMDA2LTAxLTA5IiwiZ2VuZGVyIjoiRmVtYWxlIiwibW9iaWxlX3ByaW1hcnkiOiI3MDI3NDQwMDkwIiwibW9iaWxlX3dhIjpudWxsLCJtb2JpbGVfb2ZmaWNlMSI6bnVsbCwicGhvbmUxIjpudWxsLCJwaG9uZTIiOm51bGwsImVtYWlsIjoiIiwicGFzc3dvcmQiOiI1OTEzMTdjYzk0YTdiNmM4NWM3N2ViYjU4ZDg3ZWU3MCIsInVzZXJfcHJvZmlsZV9waWMiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8yNi0xMi0yMDI0LzY3NmNlM2JhOTEyZjEtMTczNTE4OTQzNC1TYW52aS1JbmRpYS1wcm9maWxlLmpwZyIsInVzZXJfY292ZXJfaW1hZ2UiOiIvbGl2ZS9sYy1jb21tdW5pdHktMjUvcHJvZmlsZS9pbWFnZS8xMi0xMi0yMDI0LzY3NWFiODJkN2I2YzUtMTczMzk5ODYzNy1TYW52aS1JbmRpYS1wcm9maWxlLnBuZyIsInF1YWxpZmljYXRpb25faWQiOm51bGwsImVkdWNhdGlvbl9pZCI6bnVsbCwib2NjdXBhdGlvbl9pZCI6bnVsbCwicHJvZmVzc2lvbl9pZCI6bnVsbCwidXNlcl9hZGRyZXNzIjpudWxsLCJhZGRyZXNzX3BpbmNvZGUiOjExMDA0MSwiYWRkcmVzc19zdGF0ZV9pZCI6NCwiYWRkcmVzc19jaXR5X2lkIjpudWxsLCJlbGN0X3BjX2lkIjozMCwiZWxjdF9zdGF0ZV9pZCI6MywiZWxjdF9hY19pZCI6bnVsbCwiZWxjdF93YXJkX2lkIjpudWxsLCJlbGN0X3BiX2lkIjpudWxsLCJsYW5nX2lkIjo0NywicmVsaWdpb25faWQiOm51bGwsImNhc3RlX2lkIjpudWxsLCJpc192b2x1bnRlZXIiOjAsInVzZXJfYm9vdGhfd29ya2VyX2lkIjoyNjAsImlzX2xlYWRlciI6MCwiZW1haWxfdmVyaWZpZWQiOjAsImlzX29uYm9hcmRlZCI6MSwic29jaWFsX2xvZ2luX21ldGhvZCI6bnVsbCwib25saW5lX2xhbmdfaWQiOjQ3LCJzb2NpYWxfbWV0aG9kIjpudWxsLCJzb2NpYWxfZGF0YSI6bnVsbCwiYWNjb3VudF9zdGF0dXMiOjEsInJlbWFya3MiOm51bGwsImlzX2xvZ291dCI6MCwidXBkYXRlZF9hdCI6IjIwMjUtMDMtMTdUMTE6MzE6NTguMDAwWiIsImNyZWF0ZWRfYXQiOiIyMDI0LTAyLTEyVDEwOjU4OjMwLjAwMFoiLCJiaW8iOiJUZXN0IiwiY29sb3VyIjoiIzM2MzUzMyIsImlzX290cF92ZXJpZmllZCI6MCwiaXNfY2VsZWJyaXR5IjowLCJpYXQiOjE3NDI3OTYzOTZ9.3YfkzXRTIpGzmU-Nyjjri1CkoVsV8PUBaYGFx9hr0sSSFR0zoRr4ftDWysVAKFEINQwI6LbEwAgvLu-6nxarCA'
	config.id = '2387';
    config.leaderId = '25';
	config.platform = "testing";

    // Setting Headers
    config.headers = {
        Authorization: config.authToken,
        'Leader-ID': config.leaderId,
		'platform' : config.platform
		
    };
	
	config.setParams = function(apiName, params) {
	       var defaultParams = {};

	       if (apiName === 'profile') {
	           defaultParams['id'] = '2387';
	       } else if (apiName === 'timeline') {
	           defaultParams['limit'] = params.limit || '10';
	           defaultParams['skip'] = params.skip || '0';
	      
	       }

	       return karate.merge(defaultParams, params);
	   };


	   // Log environment
	   karate.log('Loaded Configuration for Environment:', env);

	   return config;
}
