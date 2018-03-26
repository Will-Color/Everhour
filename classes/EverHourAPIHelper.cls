public class EverHourAPIHelper{
    public Static String httpRequestGET(String url, String key){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setHeader('X-Api-Key', key.trim());
        HttpResponse res = h.send(req);
        system.debug(res.getBody());
        return res.getBody();
    }
    
   /* public Static String httpRequestPOST(String url){
        return null;
    }*/
}