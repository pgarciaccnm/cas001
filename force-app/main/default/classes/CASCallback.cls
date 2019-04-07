/**
 * Callback receive and manage the POST sent by CAS notifying 
 * the Availabily of the export File
 * Read: https://liaison-intl.github.io/export_files.html
 * */
public class CASCallback {
    
    public PageReference callbackreceiver(){

        String id  = ApexPages.CurrentPage().getParameters().get('id');
        
        String export_id  = ApexPages.CurrentPage().getParameters().get('export_id');
        
        String status   = ApexPages.CurrentPage().getParameters().get('status');
        
        System.debug('casfrompost'+id+' - '+export_id+' - '+status);
        
        return null;

        
    }

}