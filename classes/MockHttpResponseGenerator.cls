@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {

       // System.assertEquals('http://example.com/example/test', req.getEndpoint());
        //System.assertEquals('GET', req.getMethod());
        if(req.getEndpoint().contains('projects?')){
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"canSyncTasks":true,"users":[51515],"id":"as:587623789378408","name":"Test Project","createdAt":"2018-03-09","workspaceId":"as:587623752703430","workspaceName":"Personal","foreign":false,"favorite":false,"hasWebhook":false,"status":"open"}]');
            res.setStatusCode(200);
            return res;
        }
        if(req.getEndpoint().contains('/team/time')){
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"user":51515,"id":3681071,"datex":"2018-03-19","timex":16200,"comment":"less efforts","task":{"projects":["as:587623789378408"],"estimate":{"type":"overall","total":36000},"timex":{"total":76500,"users":{"51515":76500}},"id":"as:588657564876573","type":"task","name":"Task 1 - Understand API documentation","url":"https:app.asana.com","status":"open","labels":[],"createdAt":"2018-03-11 20:53:16","dueAt":"2018-03-13 00:00:00"},"history":[{"createdBy":51515,"id":6298907,"timex":16200,"previousTime":0,"action":"ADD","createdAt":"2018-03-19 08:22:00"}],"isLocked":false},{"user":51515,"id":3681040,"datex":"2018-03-19","timex":12600,"comment":"3.5 hours effort","task":{"projects":["as:587623789378408"],"timex":{"total":23400,"users":{"51515":23400}},"id":"as:588657562701574","type":"task","name":"Write code","url":"https:app.asana.com","status":"open","labels":[],"createdAt":"2018-03-11 20:53:55","dueAt":"2018-03-18 00:00:00"},"history":[{"createdBy":51515,"id":6298866,"timex":12600,"previousTime":0,"action":"ADD","createdAt":"2018-03-19 08:20:15"}],"isLocked":false}]');
            res.setStatusCode(200);
            return res;
        }
        
        return null;
    }
}