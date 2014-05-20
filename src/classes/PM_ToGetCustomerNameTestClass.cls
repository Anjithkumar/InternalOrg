@isTest(SeeAllData=true)
private class PM_ToGetCustomerNameTestClass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c NewServiceSalesOrder;
    
    private static void init(){
        
        
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewServiceSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.Id);
        database.insert(NewServiceSalesOrder);
    }
    
    private static Testmethod void Getcustomername()
        
    {
        
        init();
        
        NewServiceSalesOrder.Customer__c =NewDeal.Customer__c ;
        
    }
}