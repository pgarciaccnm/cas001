public with sharing class CASOpportunityManageDupe {

    public List<Opportunity> toUpdates = new List<Opportunity>();
 
    public List<Opportunity> toInserts = new List<Opportunity>();
    
    public void getNewOpportunity(List<Opportunity> newopportunities){
                
        Map<Id, Opportunity> newopportunitiesAccountIdMap = new Map<Id, Opportunity>();
        
        for(Opportunity newopportunity : newopportunities){

            newopportunitiesAccountIdMap.put(newopportunity.AccountID, newopportunity);
           
        }
        
        for(Opportunity existOpportunity : [Select Id, Name, AccountId, CloseDate, Amount, Type, StageName from Opportunity where AccountId in : newopportunitiesAccountIdMap.keyset() ]){
            
            for(Opportunity checkopportunity : newopportunities){
                
                if(checkopportunity.Name == existOpportunity.Name 
                   && checkopportunity.AccountId == existOpportunity.AccountId){
                       
                       checkopportunity.Id = existOpportunity.Id;
                       
                       toUpdates.add(checkopportunity);
                }
            }
        }
        
        for(Opportunity opportunityToUpdate : toUpdates){
            
           newopportunities.remove(newopportunities.indexOf(opportunityToUpdate));
            
        }
        
        toInserts = newopportunities;

    }
}
