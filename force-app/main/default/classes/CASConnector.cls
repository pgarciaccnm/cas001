public with sharing class CASConnector {
    public CASConnector() {

    }

       public Map<String, Object> applicants;
    
    public String identityId {get;set;}
    
    public String exportListId {get;set;}
    
    public String exportFileId {get;set;}
    
    public String download_url {get;set;}
    
    public CASConnector() {
        //curl -n https://api.webadmit.org/api/v1/exports/419356/export_files/331079 \  -H "x-api-key: 5e86514a4d1c4c05e92004afd0b1360b"
        
        //Map<String, Object> m = this.exportFileURL('419356', '331079');
        
       		
        //download_url = (String) m.get('download_url');

    }


    public static String buildRequest (String endpoint){
               
        Http http = new Http();
        HttpRequest request = new HttpRequest();
		request.setMethod('GET');
		request.setEndpoint('https://api.webadmit.org' + endpoint);
		request.setHeader('x-api-key', '5e86514a4d1c4c05e92004afd0b1360b');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            
            return (String) response.getBody();
        }

        return '';
    }

    /**
    This returns the export List
    */
    public Map<String, Object> reportList(){
        
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(buildRequest('/api/v1/exports'));
        
        return (Map<String, Object>) m.get('exports');

    }
    
    
    public Map<String, Object> reportListByIdentity(String identityId){
        
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(buildRequest('/api/v1/exports/'+identityId+'/export_files'));
        
        return (Map<String, Object>) m.get('exports');

    }
    

    public Map<String, Object> exportIdentities(){
        
                
        return (Map<String, Object>)JSON.deserializeUntyped(buildRequest('/api/v1/user_identities'));

    }
    
    public Map<String, Object> exportFileInitiate(String identityId, String exportListId){
        
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(buildRequest('/api/v1/user_identities/'+identityId+'/exports/'+exportListId+'/export_files'));
        
        return (Map<String, Object>) m.get('export_files');

    }   
    
    //https://api.webadmit.org/api/v1/exports/414666/export_files/326900
    public Map<String, Object> exportFileURL( String exportListId, String exportFileId ){
        
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(buildRequest('/api/v1/exports/'+exportListId+'/export_files/'+exportFileId));
        
        return (Map<String, Object>) m.get('export_files');

    } 
    
        
    public String downloadFile(String downloadURL){
        
      	if(downloadURL == '') return '';
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //string csvURL = downloadURL;
        //Replace any spaces with %20
        downloadURL = downloadURL.replace(' ', '%20');
        req.setEndpoint(downloadURL);
        req.setMethod('GET');
        req.setCompressed(true);
        req.setTimeout(60000);             
        HttpResponse res = null;
        res = h.send(req);
        
        return (String) res.getBody();
    }
}
