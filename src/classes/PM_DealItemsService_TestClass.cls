@isTest(seeAlldata=false)
private class PM_DealItemsService_TestClass {
    private static Customer__c testAccount;
    private static Connection__c testContact;
    private static Deal__c testDeal;
    private static Deal_Item__c testDealItem;
    private static Services__c testService;
    private static Deal_Item__c testServiceDealItem;
    
    Private static void init()
    {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        
        testContact=InitializeTestData.createConnection(testAccount.id);
        Database.insert(testContact);
        
        testDeal=InitializeTestData.createServiceDeal(testAccount.id);
        Database.insert(testDeal);
        
        testServiceDealItem=InitializeTestData.createServiceDealItem(testDeal.id);
        testService=InitializeTestdata.createServices();
        database.insert(testService);
    }
    
    private static testMethod void myUnitTest() {
        init();
        apexpages.currentpage().getparameters().put('Dealid' , testDeal.id);
        apexpages.currentpage().getparameters().put('RecordTypeName','Services' );
        PM_DealItemsServicePageController.ServiceWrapper servicewrapperinstance= new PM_DealItemsServicePageController.ServiceWrapper(testService);
        PM_DealItemsServicePageController serviceinstance= new PM_DealItemsServicePageController();
        serviceinstance.getDealServiceInstance();
        serviceinstance.ListOfServices = serviceinstance.getListOfServices();
        serviceinstance.ListOfServices[0].selectedValues = true;
        serviceinstance.selectedValues();
        serviceinstance.save();
        serviceinstance.cancel();
    }
}