global class LM_ScheduledBatchableLeaveUpdate implements Schedulable{
    
    global Integer monthToConsider ;
    global Date dateToConsider;
    global void execute(SchedulableContext sc){
        LM_CustomSetting__c currentYear = [Select Frequncy_Of_Run__c,No_Of_Annual_Leaves__c from LM_CustomSetting__c where Active__c = true limit 1];
        List<String> monthsToConsider = currentYear.Frequncy_Of_Run__c.split(';');
        for(String monthToConsider : monthsToConsider)
        {
           if((dateToConsider != null && monthToConsider !=null) || (date.today().month() == Integer.valueOf(monthToConsider)) &&  date.today().daysBetween(date.today().toStartOfMonth()) == 0)
            {
                LM_UpdateLeaveBalance b = new LM_UpdateLeaveBalance (); 
                database.executebatch(b);
            }
        }
        
        
    }
}