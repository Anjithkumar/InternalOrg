@isTest
private class TimeEntryPage_TestClass
{
    static User testUser;
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
    
    public static void init()    
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
    
        testCompany1=InitializeTestData.createCustomer();
        testCompany1.Name='ClientCompany';
        database.insert(testCompany1);
        
        testDeal1=InitializeTestData.createServiceDeal(testCompany1.Id);
        database.insert(testDeal1);
                
        testResourceForecast1=InitializeTestData.CreateResource_Forecast(testDeal1.Id);
        database.insert(testResourceForecast1);
        
        testSalesOrder1=InitializeTestData.createServiceSalesOrderTM(testDeal1.Id);
        testSalesOrder1.Customer__c = testCompany1.Id;
        testSalesOrder1.Billing_Type__c='T&M';
        database.insert(testSalesOrder1);
        
        testProject1=InitializeTestData.createProject(testSalesOrder1.Id);
        testProject1.Status__c = 'In-Progress';
        
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
        
        testSalesOrder2=InitializeTestData.createServiceSalesOrderTM(testDeal2.Id);
        testSalesOrder2.Customer__c = testCompany2.Id;
        testSalesOrder2.Billing_Type__c='T&M';
        database.insert(testSalesOrder2);
        
        testProject2=InitializeTestData.createProject(testSalesOrder2.Id);
        testProject2.Status__c = 'In-Progress';
        testProject2.Project_Code__c = '12334324534534';
        
        database.insert(testProject2);
        
        testProjectTask2=InitializeTestData.createProjectTask(testProject2.Id);
        testProjectTask2.Name = 'TestTask2';
        database.insert(testProjectTask2);
        
        testAllocation2=InitializeTestData.createAllocation(testProject2.Id,testUser.Id);
        database.insert(testAllocation2);
        
    }
    static testmethod void EnterTimeEntries()
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testUser=InitializeTestData.createUser('user25@testorg.com');
        testUser.EmployeeNumber = '1234234344';
        Profile p = [SELECT Id FROM Profile WHERE Name='Developer Force One App']; 
        testUser.ProfileId = p.Id;
        testUser.Email = 'rachit.bhargava@extentor.com';
        database.insert(testUser);
        
        System.runAs(testUser)
        {
            init();
            Test.startTest();
            PageReference pg = new PageReference('/apex/TimeEntryPage_v_1');
            Test.setCurrentPageReference(pg);
            TimeEntryController_v_1  controller = new TimeEntryController_v_1 ();
            controller.getUserProj();
            controller.projectIdValue = testProject1.id;
            controller.taskIdValue = testProjectTask1.id;
            controller.dateValue = date.today().format();
            controller.effortValue = '4';
            controller.clientrecoverable = true;
            controller.saveTimeEntryRecord();
            Test.stopTest();
        }
    }

    // Time Entry Mobile Test By Vivek
    static testmethod void EnterTimeEntriesMobile()
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testUser=InitializeTestData.createUser('user25@testorg.com');
        testUser.EmployeeNumber = '1234234344';
        Profile p = [SELECT Id FROM Profile WHERE Name='Developer Force One App']; 
        testUser.ProfileId = p.Id;
        testUser.Email = 'rachit.bhargava@extentor.com';
        database.insert(testUser);
        System.runAs(testUser)
        {
            init();
            Test.startTest();
            
            PageReference pg = new PageReference('/apex/TE_TimeEntryPage');
            pg.getHeaders().put('USER-AGENT', 'iPhone');
            Test.setCurrentPageReference(pg);
            TimeEntryPageMobileController controller = new TimeEntryPageMobileController();
		    String str = String.ValueOf(date.today().year())+'-'+String.ValueOf(date.today().month())+'-'+String.ValueOf(date.today().day());
            TimeEntryPageMobileController.saveTimeEntryRecord(testProject1.id, testProjectTask1.id,str,'Test','5',false);
            TimeEntryPageMobileController.saveTimeEntryRecord(testProject1.id, testProjectTask1.id,str,'Test2','6',true);
			TimeEntryPageMobileController.BarChartClass parm = new TimeEntryPageMobileController.BarChartClass('12',4.0);
            TimeEntryPageMobileController.queryProjectsName();
            TimeEntryPageMobileController.queryProjectTasks(testProject1.id);
            TimeEntryPageMobileController.fetchLastFiveDayTimeEntry();

           
            Test.stopTest();
        }
    }
}