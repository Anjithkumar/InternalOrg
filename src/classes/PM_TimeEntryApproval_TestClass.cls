@isTest(seeAlldata = true)
private class PM_TimeEntryApproval_TestClass
{
    static User testUser;
    static User testUserpl;
    static Customer__c testCompany1;
    static Deal__c testDeal1;
    static Resource_Forecast__c testResourceForecast1;
    static Allocation__c testAllocation1;
    static Sales_Order__c testSalesOrder1;
    static Project__c testProject1;
    static Project_Task__c testProjectTask1;
    static Sales_Order_Item__c testSalesOrderItem1;
    
    static Customer__c testCompany2;
    static Deal__c testDeal2;
    static Resource_Forecast__c testResourceForecast2;
    static Allocation__c testAllocation2;
    static Sales_Order__c testSalesOrder2;
    static Project__c testProject2;
    static Project_Task__c testProjectTask2;
    static Sales_Order_Item__c testSalesOrderItem2;
    
    static Time_Entry__c testTimeEntry1;
    static Time_Entry__c testTimeEntry2;
    static Time_Entry__c testTimeEntry3;
    static Time_Entry__c testTimeEntry4;
    static Time_Entry__c testTimeEntry5;
    static Time_Entry__c testTimeEntry6;
    static Time_Entry__c testTimeEntry7;
    static Time_Entry__c testTimeEntry8;
    
    
    public static void customSettingInit(){
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        database.insert(custominstance);
    }
    public static void init()    
    {
        
        
        
        //system.assertEquals('a','b');
        testCompany1=InitializeTestData.createCustomer();
        testCompany1.Name='ClientCompany';
        database.insert(testCompany1);
        
        testDeal1=InitializeTestData.createServiceDeal(testCompany1.Id);
        database.insert(testDeal1);
        
        
        
        
        
        testResourceForecast1=InitializeTestData.CreateResource_Forecast(testDeal1.Id);
        database.insert(testResourceForecast1);
        
        testSalesOrder1=InitializeTestData.createServiceSalesOrder(testDeal1.Id);
        testSalesOrder1.Customer__c = testCompany1.Id;
        testSalesOrder1.Billing_Type__c='T&M';
        database.insert(testSalesOrder1);
        
        testProject1=InitializeTestData.createProject(testSalesOrder1.Id);
        testProject1.Status__c = 'In-Progress';
        testProject1.Project_Lead__c = testUserpl.Id;
        database.insert(testProject1);
        
        testProjectTask1=InitializeTestData.createProjectTask(testProject1.Id);
        testProjectTask1.Name = 'TestTask1';
        database.insert(testProjectTask1);
        
        testAllocation1=InitializeTestData.createAllocation(testProject1.Id,testUser.Id);
        database.insert(testAllocation1);
        
        testCompany2=InitializeTestData.createCustomer();
        testCompany2.Name='ClientCompany1';
        database.insert(testCompany2);
        
        testDeal2=InitializeTestData.createServiceDeal(testCompany2.Id);
        database.insert(testDeal2);
        
        testResourceForecast2=InitializeTestData.CreateResource_Forecast(testDeal2.Id);
        database.insert(testResourceForecast2);
        
        testSalesOrder2=InitializeTestData.createServiceSalesOrder(testDeal2.Id);
        testSalesOrder2.Customer__c = testCompany2.Id;
        testSalesOrder2.Billing_Type__c='T&M';
        database.insert(testSalesOrder2);
        
        testProject2=InitializeTestData.createProject(testSalesOrder2.Id);
        testProject2.Name = 'Extentor-Product2';
        testProject2.Status__c = 'In-Progress';
        testProject2.Project_Code__c = '12334324534534';
        testProject2.Project_Lead__c = testUserpl.Id;
        database.insert(testProject2);
        
        testProjectTask2=InitializeTestData.createProjectTask(testProject2.Id);
        testProjectTask2.Name = 'TestTask2';
        database.insert(testProjectTask2);
        
        testAllocation2=InitializeTestData.createAllocation(testProject2.Id,testUser.Id);
        database.insert(testAllocation2);
        
        testTimeEntry1=InitializeTestData.createReadTimeEntry(testUser.Id,testProject1.Id,testProjectTask1.Id);
        testTimeEntry1.Status__c='Submitted';
        testTimeEntry1.Date__c = Date.today();
        database.insert(testTimeEntry1);
        testTimeEntry2=InitializeTestData.createReadTimeEntry(testUser.Id,testProject1.Id,testProjectTask1.Id);
        testTimeEntry2.Status__c='Submitted';
        testTimeEntry2.Date__c = Date.today();
        database.insert(testTimeEntry2);
        testTimeEntry3=InitializeTestData.createReadTimeEntry(testUser.Id,testProject1.Id,testProjectTask1.Id);
        testTimeEntry3.Status__c='Submitted';
        testTimeEntry3.Date__c = Date.today();
        database.insert(testTimeEntry3);
        testTimeEntry4=InitializeTestData.createReadTimeEntry(testUser.Id,testProject1.Id,testProjectTask1.Id);
        testTimeEntry4.Status__c='Submitted';
        testTimeEntry4.Date__c = Date.today();
        database.insert(testTimeEntry4);
        
        testTimeEntry5=InitializeTestData.createReadTimeEntry(testUser.Id,testProject2.Id,testProjectTask2.Id);
        testTimeEntry5.Status__c='Submitted';
        testTimeEntry5.Date__c = Date.today();
        database.insert(testTimeEntry5);
        testTimeEntry6=InitializeTestData.createReadTimeEntry(testUser.Id,testProject2.Id,testProjectTask2.Id);
        testTimeEntry6.Status__c='Submitted';
        testTimeEntry6.Date__c = Date.today();
        database.insert(testTimeEntry6);
        testTimeEntry7=InitializeTestData.createReadTimeEntry(testUser.Id,testProject2.Id,testProjectTask2.Id);
        testTimeEntry7.Status__c='Submitted';
        testTimeEntry7.Date__c = Date.today();
        database.insert(testTimeEntry7);
        testTimeEntry8=InitializeTestData.createReadTimeEntry(testUser.Id,testProject2.Id,testProjectTask2.Id);
        testTimeEntry8.Status__c='Submitted';
        testTimeEntry8.Date__c = Date.today();
        database.insert(testTimeEntry8);
    }        
    static testmethod void ApproveTimeEntries()
    {
        
        //customSettingInit();
        
        List<User> testUsers = new List<User>();
        
        testUser=InitializeTestData.createUser('user22@testorg.com');
        //testUser.EmployeeNumber = '1234234344';
        //Profile p = [SELECT Id FROM Profile limit 1]; 
        //testUser.ProfileId = p.Id;
        //testUser.Email = 'vivek.deepak@extentor.com';
        testUsers.add(testUser);
        
        testUserpl=InitializeTestData.createPLUser();
        /* testUserpl.EmployeeNumber = '1234234344';
UserRole r = [SELECT Id FROM UserRole WHERE Name='Project Lead'];
testUserpl.UserRoleid = r.id;
testUserpl.Email= 'rachitcse0038@gmail.com'; */
        testUsers.add(testUserpl);
        insert testUsers;
        System.runAs(testUserpl)
        {
            init();
            Test.startTest();
            PageReference pg = new PageReference('/apex/PM_TimeEntryApprovalPage');
            Test.setCurrentPageReference(pg);        
            PM_TimeEntryApprovalController controller=new PM_TimeEntryApprovalController();
            controller.OuterWrapperList=controller.getProjectName();
            controller.OuterWrapperList[0].InnerWrapperList[0].isChecked = true;
            controller.OuterWrapperList[0].InnerWrapperList[1].isChecked = true;
            controller.OuterWrapperList[1].InnerWrapperList[0].isChecked = true;
            controller.OuterWrapperList[0].InnerWrapperList[1].isChecked = true;
            controller.projName=ApexPages.currentPage().getParameters().put('projName',testProject1.Name);
            controller.getsubmittedRows();
            controller.approve();
            Test.stopTest();
            
        }
    }
    static testmethod void RejectTimeEntries()
    {
        // customSettingInit();
        
        
        testUser=InitializeTestData.createUser('user23@testorg.com');
        /*testUser.EmployeeNumber = '1234234344';
Profile p = [SELECT Id FROM Profile WHERE Name='Developer Force One App']; 
testUser.ProfileId = p.Id;
testUser.Email = 'vivek.deepak@extentor.com'; */
        database.insert(testUser);
        
        testUserpl=InitializeTestData.createPLUser();
        /*testUserpl.EmployeeNumber = '1234234344';
UserRole r = [SELECT Id FROM UserRole WHERE Name='Project Lead'];
testUserpl.UserRoleid = r.id;
testUserpl.Email= 'rachitcse0038@gmail.com'; */
        database.insert(testUserpl);
        System.runAs(testUserpl)
        {
            init();
            Test.startTest();
            PageReference pg = new PageReference('/apex/PM_TimeEntryApprovalPage');
            Test.setCurrentPageReference(pg);        
            PM_TimeEntryApprovalController controller=new PM_TimeEntryApprovalController();
            controller.OuterWrapperList=controller.getProjectName();
            controller.OuterWrapperList[0].InnerWrapperList[0].isChecked = true;
            controller.OuterWrapperList[0].InnerWrapperList[1].isChecked = true;
            controller.OuterWrapperList[1].InnerWrapperList[0].isChecked = true;
            controller.OuterWrapperList[0].InnerWrapperList[1].isChecked = true;
            controller.projName=ApexPages.currentPage().getParameters().put('projName',testProject2.Name);
            controller.getsubmittedRows();
            controller.reject();
            Test.stopTest();
            
        }
    }
}