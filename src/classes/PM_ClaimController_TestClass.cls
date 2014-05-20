@isTest
private class PM_ClaimController_TestClass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c NewServiceSalesOrder;
    private static Project__c newproject;
    private static Allocation__c newallocation ; 
    private static user newuser;
    private static Claim__c  newClaim;
    private static Claim_Items__c newClaimItem1;
    private static Claim_Items__c newClaimItem2;
    private static Claim_Items__c newClaimItem3;
    private static void init()
    {
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        newuser =InitializeTestData.createUser('user19@testorg.com');
        database.insert(newuser);
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewServiceSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.Id);
        database.insert(NewServiceSalesOrder);
        newproject = InitializeTestData.createProject(NewServiceSalesOrder.id);
        database.insert(newproject );
        newClaim = InitializeTestData.createClaim(newuser.Id);
        database.insert(newclaim);
        newClaimItem1 = InitializeTestData.createClaimitems(newClaim.Id);
        database.insert(newClaimItem1);
        newClaimItem2 = InitializeTestData.createClaimitems(newClaim.Id);
        database.insert(newClaimItem2);
        newClaimItem3 = InitializeTestData.createClaimitems(newClaim.Id);
        database.insert(newClaimItem3);
    }
    private static Testmethod void Allocation()
    {
        init();
        pagereference pr=new pagereference('/apex/PM_claimForm?id='+newclaim.id);
        Test.setCurrentPageReference(pr);
        Apexpages.StandardController sc = new Apexpages.standardController(newclaim);
        PM_ClaimController claimCon = new PM_ClaimController(sc);
        claimCon.getDetails(); 
        claimCon.getClaimItems();
        
    }
}