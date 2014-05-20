@isTest
private  class PM_ApprovalManagerSharing_TestClass
{
    static Claim__c newclaim;
    static user testUser;
    public static void init()
{




}
    static testMethod void BatchableLeaveUpdate()


{

LM_CustomSetting__c l1 = new LM_CustomSetting__c(name='testleave', No_Of_Annual_Leaves__c = 2, Frequncy_Of_Run__c='1;4;7;10' ,Active__c=True);
insert l1;
        testUser=InitializeTestData.createUser('user8@testorg.com');
database.insert(testUser);
newclaim= InitializeTestData.createClaim(testUser.id);
database.insert(newclaim);

/*List< Claim__c__Share> jShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
         RowCause FROM Claim__c__share WHERE ParentId = :newclaim.Id AND UserOrGroupId= :newclaim.Approving_Manager__c]; */
      
}

}