@isTest(seealldata= false)
public class PM_Project_addError_TestClass{
    
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c Newsalesorder;
    private static project__c NewProject1;
    private static project__c NewProject2;
    
    Private static void init()
    {
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        Newsalesorder=InitializeTestData.createServiceSalesOrder(NewDeal.id);
        database.insert(Newsalesorder);
        NewProject1=InitializeTestData.createProject(Newsalesorder.id);
        database.insert(NewProject1);
        try{
            NewProject2=InitializeTestData.createProject(Newsalesorder.id);
            database.insert(NewProject2);
        }Catch(Exception e){
            
        }
    }
    
    private static testMethod void Project_Error() {
        init();
        
    }
    
}