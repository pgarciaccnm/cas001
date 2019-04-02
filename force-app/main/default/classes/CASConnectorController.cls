public  with sharing class CASConnectorController {

    
    public CASConnectorController(){

    
    }
    
    public List<CASConnectorIdentity.user_identities> getUserIdentities(){

        CASConnectorIdentity results = CASConnector.getUserIdentities();

        List<CASConnectorIdentity.user_identities> userIdentities = (List<CASConnectorIdentity.user_identities>) results.user_identities;

        return userIdentities;
    }

    public List<CASConnectorIdentity.exports>  getAllExportsByIdentity(){

        String useridentityid = ApexPages.CurrentPage().getParameters().get('useridentityid');
        
        System.debug('cass'+useridentityid);

        CASConnectorIdentity results = CASConnector.getAllExportsByIdentity(useridentityid);

        List<CASConnectorIdentity.exports> userIdentities = (List<CASConnectorIdentity.exports>) results.exports;

        return userIdentities;

    }
}