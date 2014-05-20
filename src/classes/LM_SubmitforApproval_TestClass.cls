@isTest(SeeAllData=false)
private class LM_SubmitforApproval_TestClass{
    private static user testuser;
    private static user testuser2;
    private static Leave_Request__c testleave;
    private static Testmethod void createLeaveRequest()
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testuser= InitializeTestData.createUser('user7@testorg.com');
        database.insert(testuser);
        
        testuser2=InitializeTestData.createManagerUser(testuser.id);
        database.insert(testuser2);
        
        testleave = InitializeTestData.createLeaveRequest(testuser2.id,date.newInstance(date.today().year(),02,16),date.newInstance(date.today().year(),02,17));
        testleave.Employee__c=testuser2.id;
        testleave.Override_Validation__c=false;
        Test.startTest();
        database.insert(testleave);
        Test.stopTest();
        processinstance p  = [SELECT TargetObjectId FROM ProcessInstance WHERE TargetObjectId = :testleave.Id];    
    }
}