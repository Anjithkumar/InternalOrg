@isTest(seeAlldata=false)
private class PM_InvoiceController_FP_TestClass{
 static User testUser1;
    static User testUser2;
    static Customer__c testCompany;
    static Deal__c testDeal;
    static Resource_Forecast__c testResourceForecast1;
    static Allocation__c testAllocation1;
    static Allocation__c testAllocation2;
    static Sales_Order__c testSalesOrder;
    static Project__c testProject;
    static Sales_Order_Item__c testSalesOrderItem1;
    static Sales_Order_Item__c testSalesOrderItem2;
    static Invoice__c testInvoice;
    static Invoice_Line_Item__c testInvoiceLineItem1;
    static Invoice_Line_Item__c testInvoiceLineItem2;
    static Tax_Code__c testTaxCode;
    
    public static void init()    
    {
        
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testUser1=InitializeTestData.createUser('user31@testorg.com');
        testUser1.EmployeeNumber = '1234234344';
        database.insert(testUser1);
        
        testUser2=InitializeTestData.createUser('user32@testorg.com');
        testUser2.LastName = 'Testing1';
        testUser2.Alias = 'standt1';
        testUser2.UserName = 'test12874@extentor.com';
        testUser2.EmployeeNumber = '1234234345';
        database.insert(testUser2);
        
        testCompany=InitializeTestData.createCustomer();
        testCompany.Name='ClientCompany';
        database.insert(testCompany);
        
        testDeal=InitializeTestData.createServiceDeal(testCompany.Id);
        database.insert(testDeal);
        
        testResourceForecast1=InitializeTestData.CreateResource_Forecast(testDeal.Id);
        testResourceForecast1.Quantity__c = 2;
        database.insert(testResourceForecast1);
        
        
        testSalesOrder=InitializeTestData.createServiceSalesOrder(testDeal.Id);
        testSalesOrder.Customer__c = testCompany.Id;
        testSalesOrder.Billing_Type__c='T&M';
        testSalesOrder.Tax_Code__c = 'ST;VAT';
        testSalesOrder.Tax_Percent__c = '10;12.6';
        database.insert(testSalesOrder);
        
        testProject=InitializeTestData.createProject(testSalesOrder.Id);
        database.insert(testProject);
        
        testAllocation1=InitializeTestData.createAllocation(testProject.Id,testUser1.Id);
        database.insert(testAllocation1);
        
        testAllocation2=InitializeTestData.createAllocation(testProject.Id,testUser2.Id);
        database.insert(testAllocation2);
        
        testSalesOrderItem1=InitializeTestData.createServiceSalesOrderItem(testSalesOrder.Id);
        testSalesOrderItem1.Quantity__c=10;
        testSalesOrderItem1.Unit_Rate__c=5000;
        testSalesOrderItem1.UserId__c = testUser1.Id;
        testSalesOrderItem1.Status__c = 'Partially Invoiced';
        database.insert(testSalesOrderItem1);
        
        testSalesOrderItem2=InitializeTestData.createServiceSalesOrderItem(testSalesOrder.Id);
        testSalesOrderItem2.Quantity__c=10;
        testSalesOrderItem2.Unit_Rate__c=5000;
        testSalesOrderItem2.UserId__c = testUser2.Id;
        testSalesOrderItem2.Status__c = 'Partially Invoiced';
        database.insert(testSalesOrderItem2);
        
        testTaxCode=InitializeTestData.createTaxCode();
        database.insert(testTaxCode);
        
        testInvoice=InitializeTestData.createInvoice();
        testInvoice.Tax_Percent__c='10;25';
        database.insert(testInvoice);
        
        testInvoiceLineItem1=InitializeTestData.createInvoiceLineItem(testInvoice.id);
        testInvoiceLineItem1.Unit_Rate__c=1200;
        testInvoiceLineItem1.Invoice_Quantity__c=2;
        database.insert(testInvoiceLineItem1);
        
        testInvoiceLineItem2=InitializeTestData.createInvoiceLineItem(testInvoice.id);
        testInvoiceLineItem1.Unit_Rate__c=1500;
        testInvoiceLineItem1.Invoice_Quantity__c=12;
        database.insert(testInvoiceLineItem2);
        
        
        }
        
         static testmethod void InvoiceCreation_FP()
    {
        init();
        list<Sales_Order_Item__c> testSalesOrderItem=new list<Sales_Order_Item__c>();
        testSalesOrderItem.add(testSalesOrderItem1);
        testSalesOrderItem.add(testSalesOrderItem2);
        
        List<Invoice_Line_Item__c> testInvoiceLineItem=new List<Invoice_Line_Item__c>();
        testInvoiceLineItem.add(testInvoiceLineItem1);
        testInvoiceLineItem.add(testInvoiceLineItem2);
        
        Test.startTest();
        PageReference pg = new PageReference('/apex/PM_InvoiceCreationPage_FP?rec='+testSalesOrderItem1.Id+';'+testSalesOrderItem2.Id+'&id='+testSalesOrder.Id);
        Test.setCurrentPageReference(pg);
        ApexPages.StandardSetController sc = new ApexPages.standardSetController(testSalesOrderItem);
        sc.setSelected(testSalesOrderItem);
        PM_InvoiceCreationPageController_FP invoice_FP = new PM_InvoiceCreationPageController_FP(sc);
        invoice_FP.getItems();
        invoice_FP.getInvoiceDetails();
        invoice_FP.getAdditionalLineItems();
        invoice_FP.getNewInvoiceLineItems();
        invoice_FP.Remove();
        invoice_FP.AddToInvoice();
        invoice_FP.goToStep2();
        invoice_FP.goToStep3();
        invoice_FP.goFromStep2ToStep3();
        invoice_FP.listofnewinvoicelineItems=testInvoiceLineItem;
        //invoice_FP.Save();
        //invoice_FP.removeLink();
        }



}