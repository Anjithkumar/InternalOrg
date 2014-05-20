@isTest(seealldata=false)
private class PM_TaxCode_Testclass {
    
    private static Customer__c testAccount;
    private static Connection__c testContact;
    private static Deal__c testServiceDeal;
    private static Deal__c testLicenseDeal;
    private static Deal_Item__c testServiceDealItem;
    private static Deal_Item__c testLicenseDealItem;
    private static Sales_Order__c testServiceSalesOrder;
    private static Sales_Order__c testLicenseSalesOrder;
    private static Tax_Code__c testTaxCode;
    
    
    Private static void init()
    {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        
        testContact=InitializeTestData.createConnection(testAccount.id);
        Database.insert(testContact);
        
        testLicenseDeal=InitializeTestData.createLicenseDeal(testAccount.id);
        Database.insert(testLicenseDeal);
        
        testServiceDeal=InitializeTestData.createServiceDeal(testAccount.id);
        Database.insert(testServiceDeal);
        
        testLicenseDealItem=InitializeTestData.createLicenseDealItem(testLicenseDeal.id);
        Database.insert(testLicenseDealItem);
        
        testServiceDealItem=InitializeTestData.createServiceDealItem(testServiceDeal.id);
        Database.insert(testServiceDealItem);
        
        testServiceSalesOrder=InitializeTestData.createServiceSalesOrder(testServiceDeal.id);
        testServiceSalesOrder.Tax_Code__c='ST;GST';
        Database.insert(testServiceSalesOrder);
        
        testLicenseSalesOrder=InitializeTestData.createLicenseSalesOrder(testLicenseDeal.id,testAccount.id);
        testLicenseSalesOrder.Tax_Code__c='ST;GST';
        Database.insert(testLicenseSalesOrder);
        
        testTaxCode=InitializeTestData.createTaxCode();
        Database.insert(testTaxCode);
    }
    
    
    static testMethod void myUnitTest() {
        init();
        Boolean b=false;
        apexpages.currentpage().getparameters().put('id' , testLicenseSalesOrder.id);
        ApexPages.StandardController sc = new ApexPages.standardController(testLicenseSalesOrder);
        PM_TaxCode.TaxCodeWrapper taxWrapperInstance= new PM_TaxCode.TaxCodeWrapper(testTaxCode,b);
        PM_TaxCode taxInstance= new PM_TaxCode(sc);
        taxInstance.selectedTaxes=taxInstance.getListOfTaxes();
        taxInstance.selectedTaxes[0].selectedValues=true;
        taxInstance.save();   
    }
}