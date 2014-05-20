global class LM_ScheduledBatchableCarryForeward implements Schedulable
{
    global Integer monthToConsider ;
    global Date dateToConsider; 
    global void execute(SchedulableContext sc){
        
        
        
        
        if((dateToConsider != null && monthToConsider !=null)||date.today().month()==1 && date.today().daysBetween(date.today().toStartOfMonth()) == 0)
        {
            System.debug('-------------------------------------------');
            
            LM_LeaveCarryForwardToNextYear a = new LM_LeaveCarryForwardToNextYear ();
            database.executebatch(a);
            
        }
    }
}