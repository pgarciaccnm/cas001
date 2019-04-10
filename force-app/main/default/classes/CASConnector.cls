/**
* CASConnector is responsible to connect with WebAdmit API and 
* pull the JSON data from endpoint
* This returns the Object type associated with the endpoint
*/
public with sharing class CASConnector {

    public Map<String, Object> applicants;
    
    public String exportListId {get;set;}
    
    public String exportFileId {get;set;}
    
    public String download_url {get;set;}
    
    public CASConnector() {
        //curl -n https://api.webadmit.org/api/v1/exports/419356/export_files/331079 \  -H "x-api-key: 5e86514a4d1c4c05e92004afd0b1360b"
        
        //Map<String, Object> m = this.exportFileURL('419356', '331079');
        
       		
        //download_url = (String) m.get('download_url');

    }


    /**
     * Initiate the background execution of a specific export (e.g. export template). 
     * Required parameters are the identity that the export belongs to, and the id of 
     * the export that you wish to run. This will create an instance of a running export_file, 
     * which is what you can monitor to determine when the export is ready to be downloaded. 
     * The id in the response from this call is the handle to that running export_file and 
     * what is used in future calls to check on the status of the run.
     * 
     * {
          "export_files": {
            "id": 419356,
            "href": "/api/v1/exports/293880/export_files/419356",
            "export_id": 293880,
            "status": "Available"
          }
        }
     */
    public static CASConnectorIdentifyInvoked invokeUpdateExport(String user_identity_id, String export_list_id){
 
        return (CASConnectorIdentifyInvoked) JSON.deserialize(buildRequestInvoke( '/api/v1/user_identities/'+user_identity_id+'/exports/'+export_list_id+'/export_files').getBody(), CASConnectorIdentifyInvoked.class);

    }
    
    public static HttpResponse buildRequestInvoke(String endpoint){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
		request.setMethod('POST');
		request.setEndpoint('https://api.webadmit.org' + endpoint);
		request.setHeader('x-api-key', '5e86514a4d1c4c05e92004afd0b1360b');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            
            return response;
        }

        return null;        
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
    
    public static String getCSV(String user_identity_id, String export_list_id){
        
        CASConnectorIdentity initExportFiles =  getInitExportFile( user_identity_id,  export_list_id);
//curl -n https://api.webadmit.org/api/v1/exports/419356/export_files/331079 \  -H "x-api-key: 5e86514a4d1c4c05e92004afd0b1360b"
        List<CASConnectorIdentity.export_files> initExportFiles1 = (List<CASConnectorIdentity.export_files>) initExportFiles.export_files;
        system.debug('casza'+initExportFiles1);
                
        System.debug('cassl'+initExportFiles1[0].export_id+'-'+initExportFiles1[0].id);
        System.debug('cassa'+getExportURLFILE(initExportFiles1[0].export_id, initExportFiles1[0].id).get('download_url'));
        
        return downloadFile( (String) getExportURLFILE(initExportFiles1[0].export_id, initExportFiles1[0].id).get('download_url'));
    }
    
    public static Map<String, Object> getExportURLFILE(Integer exports, String export_file){

        //return (CASConnectorIdentity) JSON.deserialize(getResult('/api/v1/exports/'+exports+'/export_files/'+export_file).getBody(), CASConnectorIdentity.class);
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(buildRequest('/api/v1/exports/'+exports+'/export_files/'+export_file));
        
        return (Map<String, Object>) m.get('export_files');
    }

    /**
    Retrieve details on all exports (e.g. export templates) that a user has access to within 
    a specific identity. The id returned for each export is the value that 
    needs to be provided in order to run that export.
    {
        "href": "/api/v1/user_identities/24567/exports",
        "exports": [
            {
            "id": 29897,
            "name": "Nightly Banner Export",
            "list_type": "all",
            "format": "Comma-Separated Values",
            "mime_type": "text/csv;charset=iso-8859-1"
            }
        ]
        }
    */
    public static CASConnectorIdentity getAllExportsByIdentity(String user_identity_id){

        if(user_identity_id.length() == 0) return null;

        return (CASConnectorIdentity) JSON.deserialize(getResult('/api/v1/user_identities/'+user_identity_id+'/exports').getBody(), CASConnectorIdentity.class);
    }

    /**
    This returns the export List
    */
    public static CASConnectorIdentity getUserIdentities(){

        return (CASConnectorIdentity) JSON.deserialize(getResult('/api/v1/user_identities').getBody(), CASConnectorIdentity.class);

    }
    
    /**
    Retrieve details on all exports (e.g. export templates) 
    that a user has access to across all of their identities. 
    The id returned for each export is the value that needs to be provided in order to 
    run that export.
        {
        "href": "/api/v1/exports",
        "exports": [
            {
            "id": 29897,
            "name": "Nightly Banner Export",
            "list_type": "all",
            "format": "Comma-Separated Values",
            "mime_type": "text/csv;charset=iso-8859-1"
            }
        ]
        }
    */
    public static CASConnectorIdentity getAllExports(){
       
       return (CASConnectorIdentity) JSON.deserialize(getResult('/api/v1/exports').getBody(), CASConnectorIdentity.class);

    }

        
    /**
    Initiate the background execution of a specific export (e.g. export template). 
    Required parameters are the identity that the export belongs to, and the id of the export that you wish to run. 
    This will create an instance of a running export_file, which is what you can monitor to determine when the export is ready to be downloaded. 
    The id in the response from this call is the handle to that running export_file and what is used in future calls to check on the status of the run.

    {
        "export_files": {
            "id": 74780,
            "href": "/api/v1/exports/86466/export_files/74780",
            "export_id": 86446,
            "status": "Available"
        }
    }
    */
    public static CASConnectorIdentity getInitExportFile(String user_identity_id, String export_list_id){

        if(user_identity_id.length() == 0 || export_list_id.length() == 0) return null;

        return (CASConnectorIdentity) JSON.deserialize(getResult('/api/v1/user_identities/'+user_identity_id+'/exports/'+export_list_id+'/export_files').getBody(), CASConnectorIdentity.class);

    }  

    
    public Map<String, Object> user_identitiesByIdentity(String identityId){
        
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(buildRequest('/api/v1/exports/'+identityId+'/export_files'));
        
        return (Map<String, Object>) m.get('exports');

    }

    public static HttpResponse getResult(String endpoint){

        System.debug('casspoint'+endpoint);
        //String endpoint = '/api/v1/user_identities';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
		request.setMethod('GET');
		request.setEndpoint('https://api.webadmit.org' + endpoint);
		request.setHeader('x-api-key', '5e86514a4d1c4c05e92004afd0b1360b');
        HttpResponse response = http.send(request);

        System.System.debug('casResponse'+response);
        
        System.System.debug('casResponseBody'+response.getBody());
        
        if (response.getStatusCode() == 200) {
            
            return response;
        }

        return null;
    }
    
    public Map<String, Object> exportIdentities(){
              
        return (Map<String, Object>) JSON.deserializeUntyped(buildRequest('/api/v1/user_identities'));

    }
    

    
    /**
    DONT TOUCH!!!!!!
    //https://api.webadmit.org/api/v1/exports/414666/export_files/326900
    */  
    public Map<String, Object> exportFileURL( String exportListId, String exportFileId ){
        
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(buildRequest('/api/v1/exports/'+exportListId+'/export_files/'+exportFileId));
        
        return (Map<String, Object>) m.get('export_files');

    } 
    
        
    public static String downloadFile(String downloadURL){
        
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