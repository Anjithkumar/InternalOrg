@isTest(SeeAllData=false)
private class PM_CreateSalesOrderItems_TestClass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c NewServiceSalesOrder;
    private static  Sales_Order_Item__c  newServiceSalesOrderItem;
    
    private static user newuser;
    private static void init(){
        
        
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewServiceSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.Id);
        NewServiceSalesOrder.Billing_Type__c='FP';
        database.insert(NewServiceSalesOrder);
        
        newServiceSalesOrderItem=InitializeTestData.createServiceSalesOrderItem(NewServiceSalesOrder.Id);
        database.insert(newServiceSalesOrderItem);
        
    }
    
    
    private static Testmethod void Allocation()
    {
        
        init();
        pagereference pr=new pagereference('/apex/PM_CreateSalesOrderItem?id='+NewServiceSalesOrder.id);
        Test.setCurrentPageReference(pr);
        Apexpages.StandardController sc = new Apexpages.standardController(NewServiceSalesOrder);
        PM_CreateSalesOrderItems CreateSalesOrderItems= new PM_CreateSalesOrderItems (sc);
        CreateSalesOrderItems.resetQueries();
        CreateSalesOrderItems .getSalesOrderitems();
        
        CreateSalesOrderItems.Add();
        CreateSalesOrderItems.QuickSave();
        CreateSalesOrderItems.selectedValue=ApexPages.currentPage().getParameters().put('removeRow',newServiceSalesOrderItem.id);
        CreateSalesOrderItems.remove();
        
        
    }
}