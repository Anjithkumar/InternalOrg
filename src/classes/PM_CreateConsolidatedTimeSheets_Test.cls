@isTest(SeeAllData=false )
private class PM_CreateConsolidatedTimeSheets_Test
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c newSalesOrder;
    private static Consolidated_Time_Sheet__c  newConsolidatedTimeSheet;
    private static Project__c newProject; 
    private static Allocation__c newAllocation; 
    private static Resource_Forecast__c newresourceforecast;
    private static user newuser; 
    private static Project_Task__c newProjectTask;
    private static Time_Entry__c newROimeEntry;
    private static Time_Entry__c newRWEntry;
    private static void init(){
        string prevUser;
        
        
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        newresourceforecast=InitializeTestData.CreateResource_Forecast(NewDeal.id);
        database.insert(newresourceforecast);
        newSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.id);
        //newSalesOrder.Status__c='Open';
        database.insert(newSalesOrder);
        newProject=  InitializeTestData.createProject(newSalesOrder.id);
        newProject.Status__c='In-Progress';
        database.insert(newProject);
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        System.RunAs(usr)
        {
            newuser= InitializeTestData.createUser('use556r1@testorg.com');
            
            database.insert(newuser);
            
        }
        newAllocation =InitializeTestData.createAllocation(newProject.id,newuser.id);
        //newAllocation.Role__c='Developer';
        database.insert(newAllocation );
        newProjectTask=InitializeTestData.createProjectTask(newProject.id);
        
        database.insert(newProjectTask);
        //newRWEntry=InitializeTestData.createRWTimeEntry( newuser.id,newProject.id,newProjectTask.id);
        //database.insert(newRWEntry);
        newROimeEntry =InitializeTestData.createReadTimeEntry( newuser.id,newProject.id,newProjectTask.id);
        newROimeEntry.Status__c='Approved';
        database.insert(newROimeEntry);
        newConsolidatedTimeSheet =InitializeTestData.createServiceConsolidatedTimeSheet(newSalesOrder.id);
        newConsolidatedTimeSheet.UserId__c=newuser.id;
        database.insert(newConsolidatedTimeSheet);
    }
    
    private static testMethod void SalesOrdertest()
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        string prevUser;
        init();
        
        
        pagereference pr=new pagereference('/apex/PM_CreateConsolidatedTimeSheets?id='+newSalesOrder.id);
        Test.setCurrentPageReference(pr);
        
        PM_CreateConsolidatedTimeSheets controllerInstance = new PM_CreateConsolidatedTimeSheets();
        
        
        controllerInstance.wrapperlist =controllerInstance.getTableValues();
        controllerInstance.wrapperlist[0].isChecked=true;
        controllerInstance.getsubmittedRows();
        
        controllerInstance.AddItems();
        
        prevUser=newROimeEntry.Effort_Put_in_by_User__c;
        controllerInstance.create();
        newROimeEntry.Status__c = 'Processed';
        controllerInstance.selectedValue=ApexPages.currentPage().getParameters().put('removeRow',controllerInstance.wrapperlist[0].instance.id);
        
        controllerInstance.remove();
        controllerInstance.reset();
        controllerInstance.Cancel();
        controllerInstance.first();
        controllerInstance.last();
        controllerInstance.next();
        controllerInstance.previous();
        controllerInstance.goback();
        
        // newProject.id=' ';
        database.update(newProject);
        PM_CreateConsolidatedTimeSheets controllerInstance2 = new PM_CreateConsolidatedTimeSheets();
        controllerInstance2.SelectedProject=null;
        
    }
    
    
}