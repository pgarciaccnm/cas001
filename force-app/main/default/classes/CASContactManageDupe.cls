public with sharing class CASContactManageDupe {

    public List<Contact> toUpdates = new List<Contact>();
 
    public List<Contact> toInserts = new List<Contact>();
    
    public void getNewContact(List<Contact> newcontacts){
        
        Map<String, Contact> newcontactCasIds = new Map<String, Contact>();
        
        for(Contact newcontact : newcontacts){
            
            newcontactCasIds.put(newcontact.Cas_Id__c, newcontact);
        }
        
        for(Contact existContat : [Select Id, Cas_id__c, Name from Contact where Cas_id__c in : newcontactCasIds.keySet()]){
            
            if(newcontactCasIds.containsKey(existContat.Cas_Id__c)){
                
                Contact toUpdate  = newcontactCasIds.get(existContat.Cas_Id__c);
                
                toUpdate.Id = existContat.Id;
                
                toUpdates.add(newcontactCasIds.get(existContat.Cas_Id__c));
                
                newcontactCasIds.remove(existContat.Cas_Id__c);
                
            }
        }
        
        toInserts = newcontactCasIds.values();
        
    }
}
