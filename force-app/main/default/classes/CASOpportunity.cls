public with sharing class CASOpportunity  extends CASObject {

   public static List<String> requiredFields = new List<String>{'cas_id','designation_0','local_status_0','designation_1','local_status_1','designation_program_start_year_0','designation_program_start_term_0','designation_program_start_year_1','designation_program_start_term_1'};

   public List<Opportunity> opportunities;
    
    public static List<String> collectedHeaderFields;
    
    public Account acc;
  
    public boolean hasRequiredFields = false;
    
   
    public casOpportunity(){}

    public casOpportunity(List<String> collectedHeaderFields){
        
        hasRequiredFields = hasRequiredField(requiredFields, collectedHeaderFields);

    }
    
    public void addRecords(List<String> recs, List<String> collectedHeaderFields, Map<String, Contact> newContacts){
        
        List<Opportunity> allopportunities  = new List<Opportunity>();
        
        System.debug('OPP SIZE:'+recs.size()+'S');
        
        if(recs.size() > 0){
            
            Integer veces =0;
            for(String rec : recs){

                Contact newContact = newContacts.get(rec.split(',').get(0));
                
                for(Opportunity oppByAccount : parse( rec,collectedHeaderFields, newContact)){
                    
                    allopportunities.add(oppByAccount);
                    ++veces;
                }
                
            }
            
            System.debug('veces'+veces);
            
            try{
                System.debug('---size'+allopportunities.size());
               //insert allopportunities;
                
                //Database.SaveResult[] lsr = Database.insert(allopportunities, false);
                
                insert allopportunities;
                
            }catch(DmlException e) {
                        
                    System.debug('DmlException caught: ' + e.getMessage());    
                    
                } catch(SObjectException e) {
                        
                    System.debug('SObjectException caught: ' + e.getMessage());    
                    
                } catch(Exception e) {
                        
                    System.debug('Exception caught: ' + e.getMessage());    
                    
                }
            

        }
    }
    
    public List<Opportunity> parse(String rec, List<String> collectedHeaderFields, Contact newcontact){
        
        List<Opportunity>opportunities = new List<Opportunity>();
        
        List<String> collectedFields = rec.split(',');
        
        System.debug('collectedFields'+collectedFields.size());
               
        if(collectedFields.get(collectedHeaderFields.indexOf('local_status_0')).length() > 0){
            System.debug('length0 > 1'+collectedFields.get(collectedHeaderFields.indexOf('local_status_0')).length());
        }
        if(collectedFields.get(collectedHeaderFields.indexOf('local_status_0')).length() > 0){
            
            System.debug('localstatus0'+String.isEmpty(collectedFields.get(collectedHeaderFields.indexOf('local_status_0'))));
        
            Opportunity opp0 = new Opportunity();
            
            String termyear = collectedFields.get(collectedHeaderFields.indexOf('designation_program_start_term_0'))+
                                     collectedFields.get(collectedHeaderFields.indexOf('designation_program_start_year_0'));
                                                         
           
            System.debug('termyear'+termyear);

            opp0.Name = 'NDPROGRAM'+termyear;
        	opp0.AccountId = newcontact.AccountId;

            opp0.CloseDate = (termyear == 'Fall2019')?Date.valueOf('2019-08-30'):Date.valueOf('2020-01-30');
            //opp0.RecordTypeId = '0121h000000Cm4UAAS';
        	opp0.Amount = 23497.00;
            opp0.Type		= 'New Business';
            opp0.StageName	= collectedFields.get(collectedHeaderFields.indexOf('local_status_0'));
            
            opportunities.add(opp0);

        }
            
         if(collectedFields.get(collectedHeaderFields.indexOf('local_status_1')).length() > 0){
            System.debug('length11 > 1'+collectedFields.get(collectedHeaderFields.indexOf('local_status_1')).length()+'='+collectedFields.get(collectedHeaderFields.indexOf('local_status_1')));
        }           
            
        if(collectedFields.get(collectedHeaderFields.indexOf('local_status_1')).length() > 0){
                  
                System.debug('localstatus1'+String.isEmpty(collectedFields.get(collectedHeaderFields.indexOf('local_status_1'))));
                  Opportunity opp1 = new Opportunity();
                  String termyear = collectedFields.get(collectedHeaderFields.indexOf('designation_program_start_term_1'))+
                                     collectedFields.get(collectedHeaderFields.indexOf('designation_program_start_year_1'));
                
            opp1.Name = 'NDPROGRAM'+termyear;

            opp1.AccountId = newcontact.AccountId;

            opp1.CloseDate = (termyear == 'Fall2019')?Date.valueOf('2019-08-30'):Date.valueOf('2020-01-30');
            //opp1.RecordTypeId = '0121h000000Cm4UAAS';
        	opp1.Amount = 23497.00;
            
            opp1.Type		= 'New Business';
            opp1.StageName	= collectedFields.get(collectedHeaderFields.indexOf('local_status_1'));
            
            opportunities.add(opp1);
                  
           }
        
        return opportunities;
    }
}
