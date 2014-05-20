@isTest(SeeAllData=false)
private  class  LM_ScheduledBirthdayUpdateTestClass
{
    static testMethod void SchedulerBirthday()
    {
        Test.StartTest();
        
        //LM_CustomSetting__c l1 = new LM_CustomSetting__c(name='testleave', Frequncy_Of_Run__c = '1;4;7;10', No_Of_Annual_Leaves__c=2 ,Active__c=True);
        //insert l1;
        LM_Scheduledbirthday  sh1 = new LM_Scheduledbirthday  ();
       // sh1.monthToConsider = 1;
       // sh1.dateToConsider = date.newinstance(date.today().year(),01,01);
        String sch = '0 0 23 * * ?';
        system.schedule('Test', sch, sh1);
        Test.stopTest();
    }
}