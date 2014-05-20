@isTest(seeAlldata=false)
private class PM_InvoiceCreationController_TestClass
{
    static User testUser1;
    static User testUser2;
    static Customer__c testCompany;
    static Deal__c testDeal;
    static Resource_Forecast__c testResourceForecast1;
    static Allocation__c testAllocation1;
    static Allocation__c testAllocation2;
    static Sales_Order__c testSalesOrder;
    static Project__c testProject;
    static Consolidated_Time_Sheet__c testSalesOrderItem1;
    static Consolidated_Time_Sheet__c testSalesOrderItem2;
    static Invoice_Line_Item__c testInvoiceLineItem;
    
    public static void init()    
    {
        
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testUser1=InitializeTestData.createUser('user16@testorg.com');
        testUser1.EmployeeNumber = '1234234344';
        database.insert(testUser1);
        
        testUser2=InitializeTestData.createUser('user20@testorg.com');
        testUser2.LastName = 'Testing1';
        testUser2.Alias = 'standt1';
        testUser2.UserName = 'test1234@extentor.com';
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
        
        testSalesOrderItem1=InitializeTestData.createServiceConsolidatedTimeSheet(testSalesOrder.Id);
        testSalesOrderItem1.Quantity__c=10;
        testSalesOrderItem1.Unit_Rate__c=5000;
        testSalesOrderItem1.UserId__c = testUser1.Id;
        testSalesOrderItem1.Status__c = 'Completed';
        database.insert(testSalesOrderItem1);
        
        testSalesOrderItem2=InitializeTestData.createServiceConsolidatedTimeSheet(testSalesOrder.Id);
        testSalesOrderItem2.Quantity__c=10;
        testSalesOrderItem2.Unit_Rate__c=5000;
        testSalesOrderItem2.UserId__c = testUser2.Id;
        testSalesOrderItem2.Status__c = 'Completed';
        database.insert(testSalesOrderItem2);
        
        
        
    }
    static testmethod void checkInvoiceCreation()
    {
        init();
        List<Consolidated_Time_Sheet__c> listofSalesOrderItem = new List<Consolidated_Time_Sheet__c>(); 
        listofSalesOrderItem.add(testSalesOrderItem1);
        listofSalesOrderItem.add(testSalesOrderItem2);
        Test.startTest();
        PageReference pg = new PageReference('/apex/InvoiceCreationPage?rec='+testSalesOrderItem1.Id+';'+testSalesOrderItem2.Id+'&id='+testSalesOrder.Id);
        Test.setCurrentPageReference(pg);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(listofSalesOrderItem);
        sc.setSelected(listofSalesOrderItem );
        PM_InvoiceCreationPageController controller=new PM_InvoiceCreationPageController(sc);
        controller.getItems();
        controller.goToStep2();
        controller.AddToInvoice();
        controller.getInvoiceDetails();
        controller.getNewInvoiceLineItems();
        controller.getAdditionalLineItems();
        controller.Save();
        Test.stopTest();
    }
    static testmethod void checkInvoiceCreation1()
    {
        init();
        List<Consolidated_Time_Sheet__c> listofSalesOrderItem = new List<Consolidated_Time_Sheet__c>(); 
        listofSalesOrderItem.add(testSalesOrderItem1);
        listofSalesOrderItem.add(testSalesOrderItem2);
        Test.startTest();
        PageReference pg = new PageReference('/apex/InvoiceCreationPage?rec='+testSalesOrderItem1.Id+';'+testSalesOrderItem2.Id+'&id='+testSalesOrder.Id);
        Test.setCurrentPageReference(pg);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(listofSalesOrderItem);
        sc.setSelected(listofSalesOrderItem );
        PM_InvoiceCreationPageController controller=new PM_InvoiceCreationPageController(sc);
        controller.valueToRemove = String.valueOf(testSalesOrderItem1.Id);
        controller.Remove();
        controller.getItems();
        controller.goToStep2();
        controller.AddToInvoice();
        controller.getInvoiceDetails();
        controller.getNewInvoiceLineItems();
        controller.getAdditionalLineItems();
        controller.Save();
        Test.stopTest();
    }
    static testmethod void checkInvoiceCreation2()
    {
        init();
        List<Consolidated_Time_Sheet__c> listofSalesOrderItem = new List<Consolidated_Time_Sheet__c>(); 
        listofSalesOrderItem.add(testSalesOrderItem1);
        listofSalesOrderItem.add(testSalesOrderItem2);
        Test.startTest();
        PageReference pg = new PageReference('/apex/InvoiceCreationPage?rec='+testSalesOrderItem1.Id+';'+testSalesOrderItem2.Id+'&id='+testSalesOrder.Id);
        Test.setCurrentPageReference(pg);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(listofSalesOrderItem);
        sc.setSelected(listofSalesOrderItem );
        PM_InvoiceCreationPageController controller=new PM_InvoiceCreationPageController(sc);
        controller.valueToRemove = String.valueOf(testSalesOrderItem1.Id);
        controller.Remove();
        controller.getListOfTaxCodeWrappers();
        controller.getItems();
        controller.goToStep2();
        controller.goToStep3();
        controller.goFromStep2ToStep3();
        controller.AddToInvoice();
        ApexPages.currentPage().getParameters().put('removeRow','1');
        controller.removeLink();
        controller.getInvoiceDetails();
        controller.getNewInvoiceLineItems();
        controller.getAdditionalLineItems();
        controller.Save();
        Test.stopTest();
    }
    static testmethod void checkInvoiceCreation3()
    {
        init();
        testSalesOrderItem1.Status__c = 'In-Progress';
        List<Consolidated_Time_Sheet__c> listofSalesOrderItem = new List<Consolidated_Time_Sheet__c>(); 
        listofSalesOrderItem.add(testSalesOrderItem1);
        listofSalesOrderItem.add(testSalesOrderItem2);
        Test.startTest();
        PageReference pg = new PageReference('/apex/InvoiceCreationPage?rec='+testSalesOrderItem1.Id+';'+testSalesOrderItem2.Id+'&id='+testSalesOrder.Id);
        Test.setCurrentPageReference(pg);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(listofSalesOrderItem);
        sc.setSelected(listofSalesOrderItem );
        PM_InvoiceCreationPageController controller=new PM_InvoiceCreationPageController(sc);
        controller.valueToRemove = String.valueOf(testSalesOrderItem1.Id);
        controller.Remove();
        controller.getListOfTaxCodeWrappers();
        controller.getItems();
        controller.goToStep2();
        controller.goToStep3();
        controller.goFromStep2ToStep3();
        controller.AddToInvoice();
        ApexPages.currentPage().getParameters().put('removeRow','1');
        controller.removeLink();
        controller.getInvoiceDetails();
        controller.getNewInvoiceLineItems();
        controller.getAdditionalLineItems();
        controller.Save();
        Test.stopTest();
    }
    static testmethod void checkInvoiceCreation4()
    {
        init();
        testCompany.CurrencyIsoCode = 'AUD';
        database.update(testCompany);
        List<Consolidated_Time_Sheet__c> listofSalesOrderItem = new List<Consolidated_Time_Sheet__c>(); 
        listofSalesOrderItem.add(testSalesOrderItem1);
        listofSalesOrderItem.add(testSalesOrderItem2);
        Test.startTest();
        PageReference pg = new PageReference('/apex/InvoiceCreationPage?rec='+testSalesOrderItem1.Id+';'+testSalesOrderItem2.Id+'&id='+testSalesOrder.Id);
        Test.setCurrentPageReference(pg);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(listofSalesOrderItem);
        sc.setSelected(listofSalesOrderItem );
        PM_InvoiceCreationPageController controller=new PM_InvoiceCreationPageController(sc);
        controller.getItems();
        controller.goToStep2();
        controller.AddToInvoice();
        controller.getInvoiceDetails();
        controller.getNewInvoiceLineItems();
        controller.getAdditionalLineItems();
        controller.Save();
        Test.stopTest();
    }
}