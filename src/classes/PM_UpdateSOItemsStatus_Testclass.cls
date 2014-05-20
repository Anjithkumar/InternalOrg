@isTest(seeAlldata = false)
private  class PM_UpdateSOItemsStatus_Testclass
{
    Private static User testUser; 
    private static Customer__c testAccount;
    private static Connection__c testContact;
    private static Deal__c testDeal;
    private static Deal_Item__c testDealItem;
    private static Sales_Order__c testSalesorder;
    private static Project__c  testProject;
    private static Project_Task__c   testProjectTask;
    private static Time_Entry__c   testRWTimeEntry;
    private static Time_Entry__c  testReadTimeEntry;
    private static Invoice__c  testInvoice;
    private static Consolidated_Time_Sheet__c testSalesOrderItem;
    private static Invoice_Line_Item__c testInvoiceItem;
    
    Private static void init()
    {
         LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testUser=InitializeTestData.createUser('user29@testorg.com');
        Database.insert(testUser);
        
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        
        testContact=InitializeTestData.createConnection(testAccount.id);
        Database.insert(testContact);
        
        testDeal=InitializeTestData.createServiceDeal(testAccount.id);
        Database.insert(testDeal);
        
        testDealItem=InitializeTestData.createServiceDealItem(testDeal.id);
        Database.insert(testDealItem);
        
        testSalesorder=InitializeTestData.createServiceSalesOrder(testDeal.id);
        testSalesorder.Customer__c=testAccount.id;
        Database.insert(testSalesorder);
        
        testSalesOrderItem=InitializeTestData.createServiceConsolidatedTimeSheet(testSalesOrder.id);
        testSalesOrderItem.Quantity__c=10;
        testSalesOrderItem.Actual_Date__c=Date.today();
        testSalesOrderItem.Status__c='Completed';
        Database.insert(testSalesOrderItem);
        
        testInvoice=InitializeTestData.createInvoice();
        testInvoice.Tax_Code__c='VAT;ST';
        testInvoice.Tax_Percent__c='10;15';
        Database.insert(testInvoice);
        
        testInvoiceItem=InitializeTestData.createInvoiceLineItem(testInvoice.id);
        testInvoiceItem.Consolidated_Time_Sheet__c=testSalesOrderItem.id;
        testInvoiceItem.Invoice_Quantity__c=10;
        Database.insert(testInvoiceItem);
    }
    private static testMethod void updateStatus(){
        init();
        testInvoiceItem.Invoice_Quantity__c=9;
        Database.update(testInvoiceItem);
    }
    
}