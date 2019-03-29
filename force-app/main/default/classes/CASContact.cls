public with sharing class CASContact extends CASObject  {


    
	public List<String> requiredFields = new List<String>{'cas_id','last_name','first_name','date_of_birth','email'};
    
    public List<String> collectedHeaderFields;
    
    public static List<Contact> contacts = new List<Contact>();
    
    public boolean hasRequiredFields = false;

    public casContact(List<String> collectedHeaderFields){
        
        collectedHeaderFields = collectedHeaderFields;
        
        hasRequiredFields = hasRequiredField(requiredFields, collectedHeaderFields);
    }
    
    public Contact parse(String rec, List<String> collectedHeaderFields){
                         
        	Contact cont = new Contact();
        
        	List<String> collectedFields = rec.split(',');
                          
			cont.LastName 	= collectedFields.get(collectedHeaderFields.indexOf('last_name'));
            cont.FirstName 	= collectedFields.get(collectedHeaderFields.indexOf('first_name'));
            cont.Cas_Id__c 	= collectedFields.get(collectedHeaderFields.indexOf('cas_id'));
            cont.Birthdate 	= Date.valueOf(collectedFields.get(collectedHeaderFields.indexOf('date_of_birth')));
            cont.Email		= 'ss'+collectedFields.get(collectedHeaderFields.indexOf('email'));
            //cont.CasLine__c = rec;
            
        return cont;
    }
    
    
   
    public void addRecords(List<String> recs, List<String> collectedHeaderFields){
        //@todo manage when hasRequirement is false;
        If(hasRequiredFields){
            for(String rec : recs){
                
                Contact contt = parse(rec, collectedHeaderFields);
                contacts.add(contt);
            }
            
            if(contacts.size()>0){
                
                try{
                
                    casContactManageDupe casDupe = new casContactManageDupe();
                    casDupe.getNewContact(contacts);
                    
                    Database.SaveResult[] insertResult = Database.insert(casDupe.toInserts, false);
                    
                    Database.SaveResult[] updateResult = Database.update(casDupe.toUpdates, false);
  
                    List<String> contCasId = new List<String>();
                    
                    Map<String, Contact> newContact = new Map<String, Contact>();
                    
                    for(Contact cc : contacts){
                        
                        contCasId.add( cc.Cas_Id__c);
                    }
                    
                    for(Contact cc : [Select Id, AccountId, Cas_Id__c from Contact WHERE Cas_Id__c  IN : contCasId]){
                        
                        System.debug('accccountid'+cc.AccountId+' cas-id'+cc.Cas_Id__c);
                        
                        newContact.put(cc.Cas_Id__c, cc);
                    }

                    //OPPORTUNITY
					casOpportunity opp = new casOpportunity();
                    
                    opp.addRecords( recs, collectedHeaderFields, newContact);
                    
                } catch(DmlException e) {
                        
                    System.debug('DmlException caught: ' + e.getMessage());    
                    
                } catch(SObjectException e) {
                        
                    System.debug('SObjectException caught: ' + e.getMessage());    
                    
                } catch(Exception e) {
                        
                    System.debug('Exception caught: ' + e.getMessage());    
                    
                }
            }
        }
        
    }
    

}
