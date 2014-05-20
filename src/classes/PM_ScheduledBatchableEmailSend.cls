global class PM_ScheduledBatchableEmailSend implements Schedulable
{
    
    global void execute(SchedulableContext sc)
    {
        List<user> users=[select id,name,Last_TimeSheet_Filled__c,IsActive from user where IsActive=true and Last_TimeSheet_Filled__c!=null]; 
        
        for(user us:users){ 
            
            //  if(us.Last_TimeSheet_Filled__c<Date.today()){
            if(us.Last_TimeSheet_Filled__c.daysBetween(date.today())>2){ 
                PM_EmailSendUpdate b = new PM_EmailSendUpdate (); 
                database.executebatch(b);
                
            }
        }
    }                   
}