@isTest(SeeAllData=false)
private class PM_Ticket_AU_TestClass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c NewServiceSalesOrder;
    private static Ticket__c newTicket;
    
    private static user newuser;
    private static Project_Task__c newProjectTask;
    private static Project__c newProject;
    private static void init(){
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        newuser = InitializeTestData.createUser('user21@testorg.com');
        database.insert(newuser);
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewServiceSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.Id);
        NewServiceSalesOrder.Billing_Type__c='FP';
        database.insert(NewServiceSalesOrder);
        newProject=InitializeTestData.createProject(NewServiceSalesOrder.id);
        database.insert(newProject);
        newTicket =InitializeTestData.createTicket();
        database.insert(newTicket);
        newProjectTask=InitializeTestData.createProjectTask(newProject.id);
        newProjectTask.Ticket__c=newTicket.id;
        //database.insert(newProjectTask);
    }
    private static Testmethod void CreateProjectTask()
    {
        
        init();
        newTicket.Assigned_User__c=newuser.id;
        newTicket.Project__c=newProject.id;
        update newTicket; 
        
        database.insert(newProjectTask);
        
        
    }
    
    
}