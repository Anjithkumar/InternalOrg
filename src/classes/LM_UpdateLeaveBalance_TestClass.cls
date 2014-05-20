@isTest
private  class LM_UpdateLeaveBalance_TestClass
{
    static user testUser;
    static testMethod void BatchableLeaveUpdate()
{
if(Test.isRunningTest()){ 
    
 LM_CustomSetting__c l1 = new LM_CustomSetting__c(name='testleave', No_Of_Annual_Leaves__c = 2, Frequncy_Of_Run__c='1;4;7;10' ,Active__c=True);
insert l1;
testUser=InitializeTestData.createUser('user8@testorg.com');
database.insert(testUser);
testUser.Total_Leave__c=21;
database.update(testUser);
Test.StartTest();
LM_UpdateLeaveBalance lm= new LM_UpdateLeaveBalance();
lm.ContactList='select name,Total_Leave__c,Email from user where name=\'Testing\'';
ID batchid = Database.executebatch(lm);
   Test.StopTest();
   }

}
}