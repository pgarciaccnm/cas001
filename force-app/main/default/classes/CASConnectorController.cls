public with sharing class CASConnectorController {

    public List<CASConnectorIdentity.user_identities> getUserIdentities(){

        CASConnectorIdentity results = CASConnector.getUserIdentities();

        List<CASConnectorIdentity.user_identities> userIdentities = (List<CASConnectorIdentity.user_identities>) results.user_identities;

        return userIdentities;
    }

    public List<CASConnectorIdentity.exports>  getAllExportsByIdentity(){

        String user_identity_id = ApexPages.CurrentPage().getParameters().get('user_identity_id');

        CASConnectorIdentity results = CASConnector.getAllExportsByIdentity(user_identity_id);

        List<CASConnectorIdentity.exports> userIdentities = (List<CASConnectorIdentity.exports>) results.exports;

        return userIdentities;

    }
}
