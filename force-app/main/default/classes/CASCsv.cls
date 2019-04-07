/**
 * CASCsv is responsible for manage the CSV string
 * It convert the CSV string to Object
 * */
public class CASCsv {
    
    public static List<String> getCSVHeader(String csv){
        
        String headerString = csv.split('\n').get(0);
        
        System.debug('casee'+headerString.split(',').size());
        return headerString.split(',');
        
       
    }

}