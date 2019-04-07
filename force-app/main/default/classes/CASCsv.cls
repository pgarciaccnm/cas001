/**
 * CASCsv is responsible for manage the CSV string
 * It convert the CSV string to Object
 * */
public class CASCsv {
    
    private static String REGEX_001 = ',(?!(?:[^"]*"[^"]*")*[^"]*$)';
    
    public static List<String> getCSVHeader(String csv){
        
        String headerString = csv.split('\n').get(0);
        
        System.debug('casee'+headerString.split(',').size());
        return headerString.split(',');
        
       
    }
    
    public static List<List<String>> getCSVRows(String csv){
        
        List<List<String>> casBodyLine = new List<List<String>>();
        
        List<String> casCsvList = csv.split('\n');
        
        casCsvList.remove(0);

        for (Integer i=0; i < casCsvList.size() ; ++i ){
            
           casBodyLine.add(new List<String>(casCsvList.get(i).replaceAll(REGEX_001, '').replaceAll('"', '').split(',')));
        }       

        System.debug('caslistlist'+casBodyLine);
        
        return casBodyLine;
    }

}