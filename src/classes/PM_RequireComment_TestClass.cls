@isTest
private  class PM_RequireComment_TestClass
{
    static Claim__c newclaim;
    static user testUser;
    static Claim_Items__c claimitems;
    
    public static void init()
{
LM_CustomSetting__c l1 = new LM_CustomSetting__c(name='testleave', No_Of_Annual_Leaves__c = 2, Frequncy_Of_Run__c='1;4;7;10' ,Active__c=True);
insert l1;
testUser=InitializeTestData.createUser('user23348@testorg.com');
database.insert(testUser);
newclaim= InitializeTestData.createClaim(testUser.id);
database.insert(newclaim);
claimitems=InitializeTestData.createClaimitems(newclaim.id);
database.insert(claimitems);
newclaim.Approval_Comment_Check__c='Requested';
database.update(newclaim);
/*
//Id testWorkItemId = generateAndSubmitObject();
        
        // Reject the submitted request, providing a comment.
        Approval.ProcessWorkitemRequest testRej = new Approval.ProcessWorkitemRequest();
        testRej.setComments('Rejecting request with a comment.');
        testRej.setAction  ('Reject');
        testRej.setWorkitemId(testWorkItemId);
    
        Test.startTest();        
            // Process the rejection
            Approval.ProcessResult testRejResult =  Approval.process(testRej);
        Test.stopTest();
        
        // Verify the rejection results
        System.assert(testRejResult.isSuccess(), 'Rejections that include comments should be permitted');
        System.assertEquals('Rejected', testRejResult.getInstanceStatus(), 
          'Rejections that include comments should be successful and instance status should be Rejected');
*/


}
    static testMethod void BatchableLeaveUpdate()


{

    
init();
/*
// Generate sample work item using utility method.
        Id testWorkItemId = generateAndSubmitObject();
        
        // Reject the submitted request, providing a comment.
        Approval.ProcessWorkitemRequest testRej = new Approval.ProcessWorkitemRequest();
        testRej.setComments('Rejecting request with a comment.');
        testRej.setAction  ('Reject');
        testRej.setWorkitemId(testWorkItemId);
    
        Test.startTest();        
            // Process the rejection
            Approval.ProcessResult testRejResult =  Approval.process(testRej);
        Test.stopTest();
        
        // Verify the rejection results
        System.assert(testRejResult.isSuccess(), 'Rejections that include comments should be permitted');
        System.assertEquals('Rejected', testRejResult.getInstanceStatus(), 
          'Rejections that include comments should be successful and instance status should be Rejected');


 
*/
}
/*
private static Id generateAndSubmitObject()
    {
        // Create a sample invoice statement object and then submit it for approval.
       // Invoice_Statement__c testIS = new Invoice_Statement__c();
        //insert testIS;
        LM_CustomSetting__c l1 = new LM_CustomSetting__c(name='testleave', No_Of_Annual_Leaves__c = 2, Frequncy_Of_Run__c='1;4;7;10' ,Active__c=True);
insert l1;
        testUser=InitializeTestData.createUser('user8@testorg.com');
database.insert(testUser);
newclaim= InitializeTestData.createClaim(testUser.id);
database.insert(newclaim);
claimitems=InitializeTestData.createClaimitems(newclaim.id);
database.insert(claimitems);
newclaim.Approval_Comment_Check__c='Requested';
database.update(newclaim);
        
        Approval.ProcessSubmitRequest testReq = new Approval.ProcessSubmitRequest();
        testReq.setObjectId(newclaim.Id);
        Approval.ProcessResult reqResult = Approval.process(testReq);
        
        System.assert(reqResult.isSuccess(),'Unable to submit new invoice statement record for approval');
        
        return reqResult.getNewWorkitemIds()[0];
    }*/


}