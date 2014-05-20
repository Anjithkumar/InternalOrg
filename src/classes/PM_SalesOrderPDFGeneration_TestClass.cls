@isTest(seeAlldata = false)
private class PM_SalesOrderPDFGeneration_TestClass
{
    static User testUser;
    static Customer__c testCompany;
    static Deal__c testDeal;
    static Deal_Item__c testDealItem1;
    static Deal_Item__c testDealItem2;
    static Sales_Order__c testSalesOrder;
    public static void init()    
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testUser=InitializeTestData.createUser('user25@testorg.com');
        testUser.EmployeeNumber = '1234234344';
        database.insert(testUser);
        testCompany=InitializeTestData.createCustomer();
        testCompany.Name='ClientCompany';
        database.insert(testCompany);
        testDeal=InitializeTestData.createLicenseDeal(testCompany.Id);
        database.insert(testDeal);
        testSalesOrder=InitializeTestData.createLicenseSalesOrder(testDeal.Id,testCompany.Id);
        testSalesOrder.Tax_Code__c='ST;VAT';
        testSalesOrder.Tax_Percent__c='12;10';
        database.insert(testSalesOrder);
        
    }
    static testmethod void generatecheckSO()
    {
        init();
        Test.startTest();
        PageReference pg = new PageReference('/apex/PM_SalesOrderPDFGenerator?id='+testSalesOrder.Id);
        Test.setCurrentPageReference(pg);
        ApexPages.StandardController sc = new ApexPages.standardController(testSalesOrder);
        PM_SalesOrderPDFController  controller=new PM_SalesOrderPDFController (sc);
        controller.getDealItems();
        controller.getTaxCode();
        controller.getTermConditions();
        Test.stopTest();
    }
}