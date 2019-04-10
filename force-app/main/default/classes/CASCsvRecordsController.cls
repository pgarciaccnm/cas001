/**
 * Requested by js controller
 * @AuraEnabled
 * */
public with sharing class CASCsvRecordsController {

    class CSVBody{
        
        List<List<String>> csvRows {get;set;}
        
        List<String> csvHeader {get;set;}
    }
    
    @AuraEnabled
    public static CSVBody loadCSV(String csv){
        

        //The CASConnector connect with a REST server and get the CSV as String
        String fullcsvbody = CASConnector.getCSV('293880', '419356');
        
        CSVBody csvBodyObj = new CSVBody();
        
        //This is List<String> of the CSV header
        csvBodyObj.csvRows = CASCsv.getCSVRows(fullcsvbody);
        
        //This is a List<List<String>> of the line & column
        csvBodyObj.csvHeader = CASCsv.getCSVHeader(fullcsvbody);
       
        return csvBodyObj;
    }

}