@isTest(seeAllData=true)
public class TimeEntryDetail_TestClass{
    static User testUser;
    static Customer__c testCompany1;
    static Deal__c testDeal1;
    static Allocation__c testAllocation1;
    static Sales_Order__c testSalesOrder1;
    static Project__c testProject1;
    static Project_Task__c testProjectTask1;
    static Allocation__c testAllocation2;
    static Time_Entry__c timeEntry1;
    static LM_CustomSetting__c customSetting;
    static Set<User> userId = new Set<User>();
    static User timeUser;
         
    static void init(){
        customSetting = InitializeTestData.LeaveAllocation();
        Database.insert(customSetting);
        for(integer i=0;i<10;i++){
            //users
        testUser=InitializeTestData.createUser('user25@testorg.com'+i);
        testUser.EmployeeNumber = '1234234344';
        Profile p = [SELECT Id FROM Profile WHERE Name='Developer Force One App']; 
        testUser.ProfileId = p.Id;
        testUser.Email = 'extentor.admn@extentor.com';
        Database.insert(testUser);
        userId.add(testUser) ;
        }
        //Company
         testCompany1=InitializeTestData.createCustomer();
        testCompany1.Name='ClientCompany';
        Database.insert(testCompany1);
        
        //ServiceDeal
        testDeal1=InitializeTestData.createServiceDeal(testCompany1.Id);
        Database.insert(testDeal1);
        
        //SalesOrder        
        testSalesOrder1=InitializeTestData.createServiceSalesOrderTM(testDeal1.Id);
        testSalesOrder1.Customer__c = testCompany1.Id;
        testSalesOrder1.Billing_Type__c='T&M';
        Database.insert(testSalesOrder1);
        
        //Project
        testProject1=InitializeTestData.createProject(testSalesOrder1.Id);      
        testProject1.Status__c = 'In-Progress';       
        Database.insert(testProject1);
        System.debug('#####'+testProject1);
        testProjectTask1=InitializeTestData.createProjectTask(testProject1.Id);
        testProjectTask1.Name = 'TestTask1';
        Database.insert(testProjectTask1);
        
        testAllocation1=InitializeTestData.createAllocation(testProject1.Id,testUser.Id);
        Database.insert(testAllocation1);
        
        for(User timeUsers : userId){
        Integer i = 1;
        if(math.mod(i,2)==0){
        timeEntry1 = InitializeTestData.createRWTimeEntry(timeUsers.Id , testProject1.Id, testProjectTask1.Id);
        timeEntry1.Date__c = System.today();
        timeEntry1.Client_Recoverable__c = true ;
        Database.insert(timeEntry1); 
        System.debug('####'+timeEntry1);
        }else{
        timeEntry1 = InitializeTestData.createRWTimeEntry(timeUsers.Id , testProject1.Id, testProjectTask1.Id);
        timeEntry1.Date__c = System.today();
        timeEntry1.Client_Recoverable__c = false ;
        Database.insert(timeEntry1);
        System.debug('####'+timeEntry1);
        System.debug('#####'+timeEntry1.Project__r.Name);
        testProject1.Name = 'Extentor-Product'  ;
        update testProject1;
        System.debug('#####Later'+testProject1.Name);
        }   
        i = i + 1;   
        }
  }  
     static testMethod void TimeEntriesDetails(){   
            TimeEntryDetail timeEntry = new TimeEntryDetail();
            timeEntry.StartDate = '06/04/2014';
            timeEntry.EndDate = System.today().format();                    
            init();
            Test.startTest();
            TimeEntryDetail.getPiaDataForJavaScript('01/03/14',system.today().format());
            TimeEntryDetail.getGrahicalDateForBarChart('01/03/14',system.today().format());
            TimeEntryDetail.getIndividualPieChart(testUser.Id,'01/03/14',system.today().format());
            timeEntry.search();
            timeEntry.details();
            timeEntry.graphicalView();
            timeEntry.tableView();
            timeEntry.getSelectList();
            timeEntry.getPieData();
            timeEntry.getBarDataClass();
            timeEntry.getDataTableClass();
            TimeEntryDetail.getUserNames();
            TimeEntryDetail.graphicalViewJS();
            timeEntry1.Client_Recoverable__c= true;
            update timeEntry1;
            TimeEntryDetail.getIndividualPieChart(testUser.Id,'01/03/14',system.today().format());
            Test.stopTest();
     }

     static testMethod void TimeEntriesDetailsForAll(){   
            TimeEntryDetail timeEntry = new TimeEntryDetail();
            timeEntry.StartDate = '06/04/2014';
            timeEntry.EndDate = System.today().format();                    
            init();
            Test.startTest();
            timeEntry.SelectedOption = 'Vivek Deepak';
            TimeEntryDetail.getPiaDataForJavaScript('01/03/14',system.today().format());
            TimeEntryDetail.getGrahicalDateForBarChart('01/03/14',system.today().format());
            TimeEntryDetail.getIndividualPieChart(testUser.Id,'01/03/14',system.today().format());
           
            timeEntry.search();
            timeEntry.details();
            timeEntry.graphicalView();
            timeEntry.tableView();
            timeEntry.getSelectList();
            timeEntry.getPieData();
            timeEntry.getBarDataClass();
            timeEntry.getDataTableClass();
            TimeEntryDetail.getUserNames();
            TimeEntryDetail.graphicalViewJS();
            timeEntry1.Client_Recoverable__c= true;
            update timeEntry1;
            TimeEntryDetail.getIndividualPieChart(testUser.Id,'01/03/14',system.today().format());
            Test.stopTest();
     }
    static testMethod void TimeEntriesDetails_V2(){ 
        TimeEntryDetail.DataTableClass td = new TimeEntryDetail.DataTableClass('test Name','test Proj', 8, 'test desc');
        //TimeEntryDetail.getIndividualPieChart('123456','01/03/14',system.today().format());
    }
}