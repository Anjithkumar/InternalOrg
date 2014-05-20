@isTest(SeeAllData=true)
private class PM_ConsolidatedTimeSheets_FP_TestClass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c NewServiceSalesOrder;
    private static  Consolidated_Time_Sheet__c  newConsolidatedTimeSheet ;
    
    private static user newuser;
    private static void init(){
        
        
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewServiceSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.Id);
        NewServiceSalesOrder.Billing_Type__c='FP';
        database.insert(NewServiceSalesOrder);
        
        newConsolidatedTimeSheet=InitializeTestData.createServiceConsolidatedTimeSheet(NewServiceSalesOrder.Id);
        database.insert(newConsolidatedTimeSheet);
        
    }
    
    
    private static Testmethod void Allocation()
    {
        
        init();
        pagereference pr=new pagereference('/apex/PM_ConsolidatedTimeSheets_FP?id='+NewServiceSalesOrder.id);
        Test.setCurrentPageReference(pr);
        Apexpages.StandardController sc = new Apexpages.standardController(NewServiceSalesOrder);
        
        
        
        PM_ConsolidatedTimeSheets_FP CreateSalesOrderItems= new PM_ConsolidatedTimeSheets_FP(sc);
        CreateSalesOrderItems.resetQueries();
        CreateSalesOrderItems .getSalesOrderitems();
        
        CreateSalesOrderItems.Add();
        
        
        CreateSalesOrderItems.QuickSave();
        CreateSalesOrderItems.selectedValue=ApexPages.currentPage().getParameters().put('removeRow', newConsolidatedTimeSheet.id);
        CreateSalesOrderItems.remove2();
        //newConsolidatedTimeSheet.name= null;
        //update  newConsolidatedTimeSheet;
        //CreateSalesOrderItems.Add();
        
        
        
    }
}