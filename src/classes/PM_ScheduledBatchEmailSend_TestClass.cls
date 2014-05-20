@isTest
private class PM_ScheduledBatchEmailSend_TestClass {

static user testUser;
    static testMethod void myUnitTest() {
    	Test.startTest();
      testUser= [select id,Last_TimeSheet_Filled__c from user where id=:userinfo.getuserId()];
      testuser.Last_TimeSheet_Filled__c=date.today()-3;
      Database.update(testUser);
     
      PM_ScheduledBatchableEmailSend sh1 = new PM_ScheduledBatchableEmailSend();
 
        String sch = '0 0 23 * * ?';
        system.schedule('Testing', sch, sh1);
Test.stopTest();
}
    }