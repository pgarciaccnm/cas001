abstract public class CASObject {

    public boolean hasRequiredField(List<String> required, List<String> collectedHeaderFields){
        
        for(Integer i = 0; i < required.size(); i++){
            
            if(!collectedHeaderFields.contains(required.get(i))) return false;
        }
        
		return true;
    }
}
