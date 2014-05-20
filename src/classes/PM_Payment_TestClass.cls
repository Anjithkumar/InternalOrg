@isTest(seeAlldata = false)
private class PM_Payment_TestClass
{
    static User testUser;
    static Customer__c testSupplier;
    static Purchase_Order__c testPurchaseOrder;
    static Supplier_Invoice__c testSupplierInvoice;
    
    public static void init()
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testUser=InitializeTestData.createUser('user18@testorg.com');
        testUser.EmployeeNumber = '35254243';
        database.insert(testUser);
        testSupplier=InitializeTestData.createSupplier();
        database.insert(testSupplier);
        testPurchaseOrder=InitializeTestData.createPurchaseOrder();
        testPurchaseOrder.PO_Issued_By__c = testUser.Id;
        database.insert(testPurchaseOrder);
        testSupplierInvoice=InitializeTestData.createSupplierInvoice();
        testSupplierInvoice.Customer__c = testSupplier.Id;
        testSupplierInvoice.Purchase_Order__c = testPurchaseOrder.Id;
        database.insert(testSupplierInvoice);
    }
    static testmethod void checkPaymentPageCHEQUE()
    {
        init();
        
        Payment__c newPayment = new Payment__c();
        newPayment.Supplier_Account__c = testSupplier.Id;
        newPayment.Payment_Date__c = date.today();
        newPayment.Payment_Due_Date__c = date.today();
        newPayment.Amount_Paid__c = 12334556;
        newPayment.Payment_Mode__c = 'Cheque';
        Test.startTest();
        PageReference pg = new PageReference('/apex/PM_PaymentPage');
        Test.setCurrentPageReference(pg);
        
        ApexPages.StandardController sc = new ApexPages.standardController(newPayment);
        //sc.setRecord(newPayment);
        PM_PaymentPageController controller = new PM_PaymentPageController(sc);
        controller.dispSection();
        Test.stopTest();
        
    }
    static testmethod void checkPaymentPageCASH()
    {
        init();
        Payment__c newPayment = new Payment__c();
        newPayment.Supplier_Account__c = testSupplier.Id;
        newPayment.Payment_Date__c = date.today();
        newPayment.Payment_Due_Date__c = date.today();
        newPayment.Amount_Paid__c = 12334556;
        newPayment.Payment_Mode__c = 'Cash';
        Test.startTest();
        PageReference pg = new PageReference('/apex/PM_PaymentPage');
        Test.setCurrentPageReference(pg);
        
        ApexPages.StandardController sc = new ApexPages.standardController(newPayment);
        //sc.setRecord(newPayment);
        PM_PaymentPageController controller = new PM_PaymentPageController(sc);
        controller.dispSection();
        Test.stopTest();
        
    }
    static testmethod void checkPaymentPageBANKTRANSFER()
    {
        init();
        Payment__c newPayment = new Payment__c();
        newPayment.Supplier_Account__c = testSupplier.Id;
        newPayment.Payment_Date__c = date.today();
        newPayment.Payment_Due_Date__c = date.today();
        newPayment.Amount_Paid__c = 12334556;
        newPayment.Payment_Mode__c = 'Bank Transfer';
        Test.startTest();
        PageReference pg = new PageReference('/apex/PM_PaymentPage');
        Test.setCurrentPageReference(pg);
        
        ApexPages.StandardController sc = new ApexPages.standardController(newPayment);
        //sc.setRecord(newPayment);
        PM_PaymentPageController controller = new PM_PaymentPageController(sc);
        controller.dispSection();
        Test.stopTest();
    }
    static testmethod void checkPaymentPage()
    {
        init();
        Payment__c newPayment = new Payment__c();
        newPayment.Supplier_Account__c = testSupplier.Id;
        newPayment.Payment_Date__c = date.today();
        newPayment.Payment_Due_Date__c = date.today();
        newPayment.Amount_Paid__c = 12334556;
        
        Test.startTest();
        PageReference pg = new PageReference('/apex/PM_PaymentPage');
        Test.setCurrentPageReference(pg);
        
        ApexPages.StandardController sc = new ApexPages.standardController(newPayment);
        //sc.setRecord(newPayment);
        PM_PaymentPageController controller = new PM_PaymentPageController(sc);
        controller.dispSection();
        Test.stopTest();
    }
}