@isTest(seeAlldata = true)
private class PM_TimeEntrySubmission_TestClass
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
    
    public static void init_custom_setting(){
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
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
        
        testSalesOrder1=InitializeTestData.createServiceSalesOrderTM(testDeal1.Id);
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
        
        testSalesOrder2=InitializeTestData.createServiceSalesOrderTM(testDeal2.Id);
        testSalesOrder2.Customer__c = testCompany2.Id;
        testSalesOrder2.Billing_Type__c='T&M';
        database.insert(testSalesOrder2);
        
        testProject2=InitializeTestData.createProject(testSalesOrder2.Id);
        testProject2.Status__c = 'In-Progress';
        testProject2.Project_Code__c = '12334324534534';
        testProject2.Project_Lead__c = testUserpl.Id;
        database.insert(testProject2);
        
        testProjectTask2=InitializeTestData.createProjectTask(testProject2.Id);
        testProjectTask2.Name = 'TestTask2';
        database.insert(testProjectTask2);
        
        testAllocation2=InitializeTestData.createAllocation(testProject2.Id,testUser.Id);
        database.insert(testAllocation2);
        
        testTimeEntry1=InitializeTestData.createRWTimeEntry(testUser.Id,testProject1.Id,testProjectTask1.Id);
        testTimeEntry1.Status__c='Saved';
        testTimeEntry1.Date__c = Date.today();
        database.insert(testTimeEntry1);
        testTimeEntry2=InitializeTestData.createRWTimeEntry(testUser.Id,testProject1.Id,testProjectTask1.Id);
        testTimeEntry2.Status__c='Saved';
        testTimeEntry2.Date__c = Date.today();
        database.insert(testTimeEntry2);
        testTimeEntry3=InitializeTestData.createRWTimeEntry(testUser.Id,testProject1.Id,testProjectTask1.Id);
        testTimeEntry3.Status__c='Saved';
        testTimeEntry3.Date__c = Date.today();
        database.insert(testTimeEntry3);
        testTimeEntry4=InitializeTestData.createRWTimeEntry(testUser.Id,testProject1.Id,testProjectTask1.Id);
        testTimeEntry4.Status__c='Saved';
        testTimeEntry4.Date__c = Date.today();
        database.insert(testTimeEntry4);
        
        testTimeEntry5=InitializeTestData.createRWTimeEntry(testUser.Id,testProject2.Id,testProjectTask2.Id);
        testTimeEntry5.Status__c='Saved';
        testTimeEntry5.Date__c = Date.today();
        database.insert(testTimeEntry5);
        testTimeEntry6=InitializeTestData.createRWTimeEntry(testUser.Id,testProject2.Id,testProjectTask2.Id);
        testTimeEntry6.Status__c='Saved';
        testTimeEntry6.Date__c = Date.today();
        database.insert(testTimeEntry6);
        testTimeEntry7=InitializeTestData.createRWTimeEntry(testUser.Id,testProject2.Id,testProjectTask2.Id);
        testTimeEntry7.Status__c='Saved';
        testTimeEntry7.Date__c = Date.today();
        database.insert(testTimeEntry7);
        testTimeEntry8=InitializeTestData.createRWTimeEntry(testUser.Id,testProject2.Id,testProjectTask2.Id);
        testTimeEntry8.Status__c='Saved';
        testTimeEntry8.Date__c = Date.today();
        database.insert(testTimeEntry8);
        
        
    }
    static testmethod void SubmitTimeEntries()
    {
        /* LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
custominstance.name='testing';
custominstance.Active__c=true;
custominstance.No_Of_Annual_Leaves__c=21;
custominstance.Frequncy_Of_Run__c='1;4;7;9';
insert custominstance;
*/
        //init_custom_setting();
        List<User> userList = new List<User>();
        testUserpl=InitializeTestData.createUser('user298@testorg.com');
        testUserpl.EmployeeNumber = '1234234344';
        UserRole r = [SELECT Id FROM UserRole WHERE Name='Project Lead'];
        testUserpl.UserRoleid = r.id;
        testUserpl.username='blaj@blah.com';
        testUserpl.Email= 'test@testorg.com';
        userList.add(testUserpl);
        //database.insert(testUserpl);
        
        testUser=InitializeTestData.createUser('user24@testorg.com');
        testUser.EmployeeNumber = '1234234';
        Profile p = [SELECT Id FROM Profile WHERE Name='Developer Force One App']; 
        testUser.ProfileId = p.Id;
        testUser.Email = 'test1@org.com';
        userList.add(testUser);
        database.insert(userList);
        
        
        
        
        System.runAs(testUser)
        {
            init();
            Test.startTest();
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            PageReference pg = new PageReference('/apex/PM_TimeEntrySubmissionPage');
            Test.setCurrentPageReference(pg);
            Time_Entry__c newtimeentry = new Time_Entry__c();
            newtimeentry.Date__c = Date.today();
            ApexPages.StandardController sc = new ApexPages.StandardController(newtimeentry);
            //ApexPages.StandardSetController sc1 = new ApexPages.StandardSetController(newtimeentry);
            PM_TimeEntrySubmissionPageController controller = new PM_TimeEntrySubmissionPageController(sc);
            controller.next();
            //controller.getTableValues();
            controller.wrapperlist = controller.getTableValues();
            System.debug(controller.getTableValues()+'helloworld');
            controller.wrapperlist[0].isChecked=true;
            controller.wrapperlist[1].isChecked=true;
            controller.wrapperlist[6].isChecked=true;
            controller.wrapperlist[7].isChecked=true;
            controller.submitRows();
            controller.getsubmittedRows();
            controller.submit();
            System.debug(controller.wrapperlist[0].instance.Project__r.Project_Lead__r.Email);
            //Test.stopTest();
            
        }
        
    }
    
    
}