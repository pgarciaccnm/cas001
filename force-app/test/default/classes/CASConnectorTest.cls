@isTest
public with sharing class CASConnectorTest {

    /*
    Validate the List of object 
    */
    @isTest static void getAllExportsByIdentityTest(){
       // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getCASAllExportsByIdentity');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');   
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test             
        CASConnectorIdentity result = CASConnector.getAllExportsByIdentity('387184');
        // Verify mock response is not null
        System.assertNotEquals(null,result,
            'The callout returned a null response.');

 
        List<CASConnectorIdentity.user_identities> userIdentities = (List<CASConnectorIdentity.user_identities>) result.user_identities;

        System.assertEquals(null, userIdentities); 

    }

    /*
    Validate the List of object 
    */
    @isTest static void reportListTest(){
       // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getCASUserIdentities');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');   
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test             
        CASConnectorIdentity result = CASConnector.getUserIdentities();
        // Verify mock response is not null
        System.assertNotEquals(null,result,
            'The callout returned a null response.');

 
        List<CASConnectorIdentity.user_identities> userIdentities = (List<CASConnectorIdentity.user_identities>) result.user_identities;

        System.assertEquals(138281, userIdentities.get(0).id); 

    }

    @isTest static void exportTest(){
       // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getCASExport');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');   
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test             
        CASConnectorIdentity result = CASConnector.getAllExports();
        // Verify mock response is not null
        System.assertNotEquals(null,result,
            'The callout returned a null response.');

            System.debug('cass'+result);

 
        List<CASConnectorIdentity.exports> allExports = (List<CASConnectorIdentity.exports>) result.exports;

       System.assertEquals(363799, allExports.get(0).id); 

    }

    @isTest static void exportIdentitiesTest(){

        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getCASUserIdentities');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');   
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test             
        HttpResponse result = CASConnector.getResult('/api/v1/exports');
        // Verify mock response is not null
        System.assertNotEquals(null,result,
            'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(),
          'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
          result.getHeader('Content-Type'),
          'The content type value is not expected.');  
        // Verify the array contains 3 items     
       CASConnectorIdentity results = (CASConnectorIdentity) 
            JSON.deserialize(result.getBody(), CASConnectorIdentity.class);

            system.System.debug('ss'+results);
            
            
        List<CASConnectorIdentity.user_identities> userIdentities = (List<CASConnectorIdentity.user_identities>) results.user_identities;
        System.assertEquals(5, userIdentities.size());

     
        // Verify the sfdx objec
        System.assertEquals(138281, userIdentities.get(0).id); 
  
        

    }
}
