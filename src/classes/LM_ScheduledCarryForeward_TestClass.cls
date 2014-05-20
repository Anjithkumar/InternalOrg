@isTest
private  class  LM_ScheduledCarryForeward_TestClass
{
    static testMethod void Scheduler1()
    {
        Test.StartTest();
        
        LM_CustomSetting__c l1 = new LM_CustomSetting__c(name='testleave', Frequncy_Of_Run__c = '1;4;7;10', No_Of_Annual_Leaves__c=2 ,Active__c=True);
        insert l1;
        
        LM_ScheduledBatchableCarryForeward sh1 = new LM_ScheduledBatchableCarryForeward ();
        sh1.monthToConsider = 1;
        sh1.dateToConsider = date.newinstance(date.today().year(),01,01);
        //LM_UpdateLeaveBalance b = new LM_UpdateLeaveBalance ();
        //database.executebatch(b);
        String sch = '0 0 23 * * ?';
        system.schedule('Test', sch, sh1);
        Test.stopTest();
    }
}