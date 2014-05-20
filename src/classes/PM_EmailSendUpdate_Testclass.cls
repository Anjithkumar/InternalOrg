@isTest(seealldata=false)
private class PM_EmailSendUpdate_Testclass {
    
    private static Customer__c newCustomer;
    private static Deal__c newDeal;
    private static Sales_Order__c newSalesOrder;
    private static Sales_Order_Item__c newsalesorderitems;
    private static Project__c newProject; 
    private static Allocation__c newAllocation; 
    private static Resource_Forecast__c newresourceforecast;
    private static user newuser; 
    private static Project_Task__c newProjectTask;
    private static Time_Entry__c newROimeEntry;
    private static Time_Entry__c newRWEntry;
    
    private static void init()
    { 
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        newuser=InitializeTestData.createUser('user13@testorg.com');
        newCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        newDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        newresourceforecast=InitializeTestData.CreateResource_Forecast(NewDeal.id);
        database.insert(newresourceforecast);
        newSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.id);
        database.insert(newSalesOrder);
        newProject=  InitializeTestData.createProject(newSalesOrder.id);
        newProject.Status__c='In-Progress';
        database.insert(newProject);
        newAllocation =InitializeTestData.createAllocation(newProject.id,newuser.id);
        database.insert(newAllocation );
        newProjectTask=InitializeTestData.createProjectTask(newProject.id);
        database.insert(newProjectTask);
        string userid=userinfo.getuserid();
        newROimeEntry =InitializeTestData.createReadTimeEntry(userid,newProject.id,newProjectTask.id);
        newROimeEntry.Status__c='Saved';
        database.insert(newROimeEntry);
        newsalesorderitems =InitializeTestData.createServiceSalesOrderItem(newSalesOrder.id);
        newsalesorderitems.UserId__c=userid;
        database.insert(newsalesorderitems);
        
    }
    static testMethod void BatchableLeaveUpdate()
    {
        init();
        Test.StartTest();
        PM_EmailSendUpdate pm= new PM_EmailSendUpdate();
        pm.unSubmittedTimeEntries='select id,name,Effort_Put_in_by_User__c,Effort_Put_in_by_User__r.Email,Project__r.Project_Type__c,CreatedDate,Status__c from Time_Entry__c where Project__r.Project_Type__c=\'Client Recoverable\' AND Status__c=\'Saved\'';
        ID batchid = Database.executeBatch(pm);
        Test.StopTest();
        
    }
}