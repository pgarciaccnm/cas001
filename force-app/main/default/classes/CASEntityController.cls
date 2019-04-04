public class CASEntityController {

    public CASEntityController(){}
        
    public PageReference getAllExportByIdentityView(){
        
        getAllExportsByIdentity();
        
        return null;
    }
    
       
    public List<CASConnectorIdentity.exports>  getAllExportsByIdentity(){

        String useridentityid = ApexPages.CurrentPage().getParameters().get('useridentityid');
        
        System.debug('cass'+useridentityid);

        CASConnectorIdentity results = CASConnector.getAllExportsByIdentity(useridentityid);

        List<CASConnectorIdentity.exports> userIdentities = (List<CASConnectorIdentity.exports>) results.exports;

        return userIdentities;

    }
}