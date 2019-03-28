public with sharing class CASConnectorController {

    public List<CASConnectorIdentity.user_identities> getUserIdentities(){

        CASConnectorIdentity results = CASConnector.getUserIdentities();

        List<CASConnectorIdentity.user_identities> userIdentities = (List<CASConnectorIdentity.user_identities>) results.user_identities;

        return userIdentities;
    }
}
