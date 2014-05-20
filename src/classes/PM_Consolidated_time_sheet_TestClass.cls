@isTest(SeeAllData=false)
private class  PM_Consolidated_time_sheet_TestClass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c newSalesOrder;
    private static Sales_Order_Item__c newsalesorderitems;
    private static Project__c newProject; 
    private static Allocation__c newAllocation; 
    private static Resource_Forecast__c newresourceforecast;
    private static Consolidated_Time_Sheet__c newConsolidatedTimeSheet;
    private static user newuser; 
    private static Ticket__c newticket; 
    private static LM_CustomSetting__c  newCustomsetting;
    //@future     
    private static void init()
    {
        
        //Test.startTest();
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        
        System.RunAs(usr)
        {
            
            newuser= InitializeTestData.createPLUser();
            database.insert(newuser);
            
        }
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        newresourceforecast=InitializeTestData.CreateResource_Forecast(NewDeal.id);
        database.insert(newresourceforecast);
        newSalesOrder=InitializeTestData.createServiceSalesOrderTM(NewDeal.id);
        newSalesOrder.Status__c='Open';
        newSalesOrder.Project_Category__c='Maintenance';
        database.insert(newSalesOrder);
        newProject=  InitializeTestData.createProject(newSalesOrder.id);
        newProject.Project_Code__c='X-00-11-@231-&125';
        newProject.Project_Category__c='Maintenance';
        database.insert(newProject);
        
        newAllocation =InitializeTestData.createAllocation(newProject.id,newuser.id);
        //newAllocation.Role__c='Developer';
        database.insert(newAllocation );
        newticket =InitializeTestData.createTicket();
        newticket.Assigned_User__c=newuser.id;
        newticket.Project__c =newProject.id;
        database.insert(newticket);
        
        
        newsalesorderitems =InitializeTestData.createServiceSalesOrderItem(newSalesOrder.id);
        newsalesorderitems.UserId__c=newuser.id;
        database.insert(newsalesorderitems);
        newConsolidatedTimeSheet=InitializeTestData.createServiceConsolidatedTimeSheet(newSalesOrder.id);
        newConsolidatedTimeSheet.UserId__c=newuser.id;
        database.insert(newConsolidatedTimeSheet);
        //Test.stopTest();
        
        
    }
    
    // @future 
    
    private static void init2()
        
    {
        //Test.startTest();
        
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        
        System.RunAs(usr)
        {
            
            newuser= InitializeTestData.createUser('user12@testorg.com');
            
            database.insert(newuser);
        }
        
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        newresourceforecast=InitializeTestData.CreateResource_Forecast(NewDeal.id);
        database.insert(newresourceforecast);
        newSalesOrder=InitializeTestData.createServiceSalesOrderTM(NewDeal.id);
        newSalesOrder.Status__c='Open';
        newSalesOrder.Project_Category__c='CB-LAUNCHPAD';
        database.insert(newSalesOrder);
        newProject=  InitializeTestData.createProject(newSalesOrder.id);
        newProject.Project_Category__c='CB-LAUNCHPAD';
        database.insert(newProject);
        
        newAllocation =InitializeTestData.createAllocation(newProject.id,newuser.id);
        //newAllocation.Role__c='Developer';
        database.insert(newAllocation );
        newsalesorderitems =InitializeTestData.createServiceSalesOrderItem(newSalesOrder.id);
        newsalesorderitems.UserId__c=newuser.id;
        database.insert(newsalesorderitems);
        newConsolidatedTimeSheet=InitializeTestData.createServiceConsolidatedTimeSheet(newSalesOrder.id);
        newConsolidatedTimeSheet.UserId__c=newuser.id;
        database.insert(newConsolidatedTimeSheet);
        //Test.stopTest();
        
        
        
    }
    
    
    
    //@future 
    private static void init3()
    {
        //Test.startTest();
        
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        
        System.RunAs(usr)
        {
            newuser= InitializeTestData.createPLUser();
            newuser.UserName='test1234567@extentor.com';
            database.insert(newuser);
            
        }
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        newresourceforecast=InitializeTestData.CreateResource_Forecast(NewDeal.id);
        database.insert(newresourceforecast);
        newSalesOrder=InitializeTestData.createServiceSalesOrderTM(NewDeal.id);
        newSalesOrder.Status__c='Closed - Invoiced';
        newSalesOrder.Project_Category__c='CB-LAUNCHPAD';
        newSalesOrder.Billing_Type__c='FP';
        database.insert(newSalesOrder);
        newProject=  InitializeTestData.createProject(newSalesOrder.id);
        newProject.Project_Code__c='X-00-11-@231-&125456';
        newProject.Project_Category__c='CB-LAUNCHPAD';
        database.insert(newProject);
        User usr1 = [Select id from User where Id = :UserInfo.getUserId()];
        
        System.RunAs(usr1)
        {
            newuser= InitializeTestData.createPLUser();
            newuser.UserName='test123456789@extentor.com';
            database.insert(newuser);
        }
        newAllocation =InitializeTestData.createAllocation(newProject.id,newuser.id);
        //newAllocation.Role__c='Developer';
        database.insert(newAllocation );
        newticket =InitializeTestData.createTicket();
        newticket.Assigned_User__c=newuser.id;
        newticket.Project__c =newProject.id;
        database.insert(newticket);
        
        
        newsalesorderitems =InitializeTestData.createServiceSalesOrderItem(newSalesOrder.id);
        newsalesorderitems.UserId__c=newuser.id;
        database.insert(newsalesorderitems);
        newConsolidatedTimeSheet=InitializeTestData.createServiceConsolidatedTimeSheet(newSalesOrder.id);
        newConsolidatedTimeSheet.UserId__c=newuser.id;
        database.insert(newConsolidatedTimeSheet);
        //Test.stopTest();
        
        
    }
    
    // @future 
    private static void init4()
    {
        
        // Test.startTest();
        
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        
        System.RunAs(usr)
        {
            newuser= InitializeTestData.createPLUser();
            newuser.UserName='test12345678@extentor.com';
            database.insert(newuser);     
        }
        
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        newresourceforecast=InitializeTestData.CreateResource_Forecast(NewDeal.id);
        database.insert(newresourceforecast);
        newSalesOrder=InitializeTestData.createServiceSalesOrderTM(NewDeal.id);
        newSalesOrder.Status__c='Closed - Invoiced';
        newSalesOrder.Project_Category__c='Maintenance';
        newSalesOrder.Billing_Type__c='T&M';
        database.insert(newSalesOrder);
        newProject=  InitializeTestData.createProject(newSalesOrder.id);
        newProject.Project_Code__c='X-00-11-@231-&125456';
        newProject.Project_Category__c='Maintenance';
        database.insert(newProject);
        
        newAllocation =InitializeTestData.createAllocation(newProject.id,newuser.id);
        //newAllocation.Role__c='Developer';
        database.insert(newAllocation );
        newticket =InitializeTestData.createTicket();
        newticket.Assigned_User__c=newuser.id;
        newticket.Project__c =newProject.id;
        database.insert(newticket);
        
        
        newsalesorderitems =InitializeTestData.createServiceSalesOrderItem(newSalesOrder.id);
        newsalesorderitems.UserId__c=newuser.id;
        database.insert(newsalesorderitems);
        newConsolidatedTimeSheet=InitializeTestData.createServiceConsolidatedTimeSheet(newSalesOrder.id);
        newConsolidatedTimeSheet.UserId__c=newuser.id;
        database.insert(newConsolidatedTimeSheet);
        //Test.stopTest();
        
    }
    
    
    
    
    private static Testmethod void SalesorderitemStatusupdate()
    {
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        init();
        init2();
        init3();
        
        newSalesOrder.Status__c='Closed - Invoiced';
        update newSalesOrder ;
        
    }
    
    private static Testmethod void SalesorderitemStatusupdate2()
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        init4();
        
        
        newSalesOrder.Status__c='Closed - Invoiced';
        update newSalesOrder ;
        
    }
    
    
    
    
    
}