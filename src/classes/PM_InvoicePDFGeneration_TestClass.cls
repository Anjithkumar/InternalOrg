@isTest(seeAlldata = true)
private class PM_InvoicePDFGeneration_TestClass
{
    static User testUser;
    static Customer__c testCompany;
    static Deal__c testDeal;
    static Resource_Forecast__c testResourceForecast;
    static Allocation__c testAllocation;
    static Sales_Order__c testSalesOrder;
    static Project__c testProject;
    static Sales_Order_Item__c testSalesOrderItem;
    static Invoice__c testInvoice;
    static Invoice_Line_Item__c testInvoiceLineItem;
    public static void init()    
    {
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testUser=InitializeTestData.createUser('user17@testorg.com');
        testUser.EmployeeNumber = '1234234344';
        database.insert(testUser);
        testCompany=InitializeTestData.createCustomer();
        testCompany.Name='ClientCompany';
        database.insert(testCompany);
        testDeal=InitializeTestData.createServiceDeal(testCompany.Id);
        database.insert(testDeal);
        testResourceForecast=InitializeTestData.CreateResource_Forecast(testDeal.Id);
        database.insert(testResourceForecast);
        testSalesOrder=InitializeTestData.createServiceSalesOrder(testDeal.Id);
        testSalesOrder.Customer__c = testCompany.Id;
        testSalesOrder.Billing_Type__c='T&M';
        
        database.insert(testSalesOrder);
        testProject=InitializeTestData.createProject(testSalesOrder.Id);
        database.insert(testProject);
        testAllocation=InitializeTestData.createAllocation(testProject.Id,testUser.Id);
        database.insert(testAllocation);
        testSalesOrderItem=InitializeTestData.createServiceSalesOrderItem(testSalesOrder.Id);
        testSalesOrderItem.Quantity__c=10;
        testSalesOrderItem.Unit_Rate__c=5000;
        testSalesOrderItem.UserId__c = ''+testUser.Id;
        database.insert(testSalesOrderItem);
        
        testInvoice=InitializeTestData.createInvoice();
        testInvoice.Tax_Percent__c = '12;43';
        testInvoice.Tax_Code__c = 'ST;VAT';
        database.insert(testInvoice);
        testInvoiceLineItem=InitializeTestData.createInvoiceLineItem(testInvoice.Id);
        testInvoiceLineItem.Invoice_Quantity__c=testSalesOrderItem.Quantity__c;
        testInvoiceLineItem.Unit_Rate__c=testSalesOrderItem.Unit_Rate__c;
        database.insert(testInvoiceLineItem);
    }
    static testmethod void checkInvoicePDF()
    {
        init();
        Test.startTest();
        PageReference pg = new PageReference('/apex/PM_PDFGenerationPage?id='+testInvoice.Id);
        Test.setCurrentPageReference(pg);
        ApexPages.StandardController sc = new ApexPages.standardController(testInvoice);
        PM_InvPDFGenerationPageController controller = new PM_InvPDFGenerationPageController(sc);
        controller.getInvoiceLineItem();
        controller.getTaxCode();
        Test.stopTest();
    }
}