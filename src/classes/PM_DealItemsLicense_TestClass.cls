@isTest(seeAlldata=false)
private class PM_DealItemsLicense_TestClass {
    private static Customer__c testAccount;
    private static Connection__c testContact;
    private static Deal__c testDeal;
    private static Deal_Item__c testDealItem;
    private static License__c testLicense;
    private static Deal_Item__c testLicenseDealItem;
    
    // initializing test data
    Private static void init()
    {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        
        testContact=InitializeTestData.createConnection(testAccount.id);
        Database.insert(testContact);
        
        testDeal=InitializeTestData.createLicenseDeal(testAccount.id);
        Database.insert(testDeal);
        
        testLicenseDealItem=InitializeTestData.createLicenseDealItem(testDeal.id);
        testLicense=InitializeTestdata.createLicenses();
        database.insert(testLicense);
    }
    
    private static testMethod void myUnitTest() {
        init(); 
        apexpages.currentpage().getparameters().put('Dealid' , testDeal.id);
        apexpages.currentpage().getparameters().put('RecordTypeName','Licenses' );
        Test.startTest();
        PM_DealItemsLicensePageController.LicenseWrapper licensewrapperinstance= new PM_DealItemsLicensePageController.LicenseWrapper(testLicense);
        PM_DealItemsLicensePageController licenseinstance= new PM_DealItemsLicensePageController();
        licenseinstance.getDealInstance();
        licenseinstance.ListOfLicenses = licenseinstance.getListOfLicenses();
        licenseinstance.ListOfLicenses[0].selectedValues=true;
        Date startDate=Date.today();
        string startdateformat=startdate.format();
        Date endDate = startdate.addDays(2);
        string enddateformat=endDate.format();
        licenseinstance.ListOfLicenses[0].startDate =startdateformat ;
        licenseinstance.ListOfLicenses[0].endDate = enddateformat;
        licenseinstance.save();
        licenseinstance.cancel();
        licenseinstance.ListOfLicenses[0].startDate =string.valueof(Date.today());
        licenseinstance.save();
        Test.stopTest();
    }
}