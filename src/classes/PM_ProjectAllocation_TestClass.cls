@isTest(SeeAllData=false)
private class PM_ProjectAllocation_TestClass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c NewServiceSalesOrder;
    private static Project__c newproject;
    private static Allocation__c newallocation ; 
    private static user newuser;
    private static void init(){
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        newuser =InitializeTestData.createUser('user19@testorg.com');
        database.insert(newuser);
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewServiceSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.Id);
        database.insert(NewServiceSalesOrder);
        newproject = InitializeTestData.createProject(NewServiceSalesOrder.id);
        database.insert(newproject );
        newallocation =InitializeTestData.createAllocation(newproject.id,newuser.id);
        database.insert(newallocation );
        
        
    }
    
    
    private static Testmethod void Allocation()
    {
        
        init();
        pagereference pr=new pagereference('/apex/PM_ProjectAllocation?id='+newproject.id);
        Test.setCurrentPageReference(pr);
        Apexpages.StandardController sc = new Apexpages.standardController(newproject );
        
        
        
        PM_ProjectAllocation  ProjectAllocation = new PM_ProjectAllocation (sc);
        ProjectAllocation .resetQueries();
        ProjectAllocation .getAllocation();
        ProjectAllocation.getAvailableRoles();
        ProjectAllocation .Add();
        //ProjectAllocation .selectedValue=NewResource_Forecast.id;
        
        ProjectAllocation.selectedValue=ApexPages.currentPage().getParameters().put('removeRow',newallocation.id);
        ProjectAllocation .remove();
        newallocation =InitializeTestData.createAllocation(newproject.id,null);
        database.insert(newallocation );
        ProjectAllocation .Add();
        
        
    }
}