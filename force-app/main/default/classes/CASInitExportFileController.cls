public with sharing class CASInitExportFileController {
    
    public CASInitExportFileController() {
                
        List<CASConnectorIdentity.export_files> initExportFiles = getExportFileByIdentity();
        
        
        System.debug('cass'+initExportFiles[0].href);
    }

       
    public PageReference getRecordFile(){
        
        List<CASConnectorIdentity.export_files> initExportFiles = getExportFileByIdentity();
        
        
        System.debug('cass'+initExportFiles[0].href);

        String downloadURL = '';

        String results = CASConnector.downloadFile(downloadURL);
        
        return null;
    }
    
    public List<String> getHeader(){
        
        return CASCsv.getCSVHeader(getCSV());
    }
    
    public List<List<String>> getRows(){
        
        return CASCsv.getCSVRows(getCSV());
    }
    
    public String getCSV(){
        String useridentityid = ApexPages.CurrentPage().getParameters().get('useridentityid');

        String exportid = ApexPages.CurrentPage().getParameters().get('exportid');        
        
        return CASConnector.getCSV(useridentityid, exportid);
    }
    
       
    public List<CASConnectorIdentity.export_files>  getExportFileByIdentity(){

        String useridentityid = ApexPages.CurrentPage().getParameters().get('useridentityid');

        String exportid = ApexPages.CurrentPage().getParameters().get('exportid');
        
        CASConnectorIdentity results = CASConnector.getInitExportFile(useridentityid, exportid);
                

        List<CASConnectorIdentity.export_files> initExportFiles = (List<CASConnectorIdentity.export_files>) results.export_files;

        System.debug('casa'+initExportFiles);
        
        return initExportFiles;

    }


    
}