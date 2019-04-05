public class CASEntityController {


    public CASEntityController(){}
    
    public String getUseridentityid(){
        
        return ApexPages.CurrentPage().getParameters().get('useridentityid');
    }
        
    public PageReference getAllExportByIdentityView(){
        
        getAllExportsByIdentity();
        
        return null;
    }
    
       
    public List<CASConnectorIdentity.exports>  getAllExportsByIdentity(){

        //String useridentityid = ApexPages.CurrentPage().getParameters().get('useridentityid');
        
        System.debug('cass'+getUseridentityid());

        CASConnectorIdentity results = CASConnector.getAllExportsByIdentity(getUseridentityid());

        List<CASConnectorIdentity.exports> userIdentities = (List<CASConnectorIdentity.exports>) results.exports;

        return userIdentities;

    }
}