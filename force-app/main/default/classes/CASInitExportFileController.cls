public with sharing class CASInitExportFileController {
    
    public CASInitExportFileController() {

    }

       
    public PageReference getAllExportFileByIdentityView(){
        
        getExportFileByIdentity();
        
        return null;
    }
    
       
    public List<CASConnectorIdentity.InitExportFile>  getExportFileByIdentity(){

        String useridentityid = ApexPages.CurrentPage().getParameters().get('useridentityid');

        String exportid = ApexPages.CurrentPage().getParameters().get('exportid');
        
        System.debug('cass'+useridentityid);

        CASConnectorIdentity results = CASConnector.getInitExportFile(useridentityid, exportid);

        List<CASConnectorIdentity.InitExportFile> initExportFiles = (List<CASConnectorIdentity.InitExportFile>) results.init_export_file;

        return initExportFiles;

    }


    
}
