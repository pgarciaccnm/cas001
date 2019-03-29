public with sharing class CASAllExportController {

    public List<CASConnectorIdentity.exports> getAllExportReport(){

        CASConnectorIdentity results = CASConnector.getAllExports();

        List<CASConnectorIdentity.exports> userIdentities = (List<CASConnectorIdentity.exports>) results.exports;

        return userIdentities;


    }
}
