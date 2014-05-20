@isTest(SeeAllData=false)
private class PM_UpdatingProjectCategory_TestClass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c NewServiceSalesOrder;
    private static Project__c newproject;
    private static Allocation__c newallocation ; 
    private static user newuser;
    private static void init()
    {
    
     LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        newuser =InitializeTestData.createUser('user28@testorg.com');
        database.insert(newuser );
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewServiceSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.Id);
        database.insert(NewServiceSalesOrder);
        newproject = InitializeTestData.createProject(NewServiceSalesOrder.id);
        newproject.Project_Category__c='CB-CUSTOM-SOW';
        database.insert(newproject );
        
        
        
    }
    private static Testmethod void Allocation()
    {
        
        init();
        
     newproject.Project_Category__c='CB-CUSTOM-SOW';
     Update newproject;
     
     
     }
     
     }