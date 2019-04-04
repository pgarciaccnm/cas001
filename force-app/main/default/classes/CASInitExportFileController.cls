public with sharing class CASInitExportFileController {
    
    public CASInitExportFileController() {
        getExportFileByIdentity();
    }

       
    public PageReference getRecordFile(){
        
        getExportFileByIdentity();

        String downloadURL = '';

        String results = CASConnector.downloadFile(downloadURL);
        
        return null;
    }
    
       
    public List<CASConnectorIdentity.export_files>  getExportFileByIdentity(){

        String useridentityid = ApexPages.CurrentPage().getParameters().get('useridentityid');

        String exportid = ApexPages.CurrentPage().getParameters().get('exportid');
        
        system.debug('cas'+useridentityid+'|'+exportid);
        


        CASConnectorIdentity results = CASConnector.getInitExportFile(useridentityid, exportid);

        List<CASConnectorIdentity.export_files> initExportFiles = (List<CASConnectorIdentity.export_files>) results.export_files;

        System.debug('casa'+initExportFiles);
        
        return initExportFiles;

    }


    
}