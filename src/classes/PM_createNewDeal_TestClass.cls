@isTest
private class  PM_createNewDeal_TestClass {
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    
    
    Private static void init()
    {
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createLicenseDeal(NewCustomer.id);
        database.insert(NewDeal);
        
        
    }
    
    private static testMethod void myUnitTest() {
        init(); 
        NewDeal.Client_Renewal__c=true;
        update NewDeal;
        
    }
}