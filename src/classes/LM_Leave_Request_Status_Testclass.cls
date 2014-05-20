@isTest(seeallData=false)
private class LM_Leave_Request_Status_Testclass {
    
    //Intialize
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Sales_Order__c NewServiceSalesOrder;
    private static Project__c newproject;
    private static Allocation__c newallocation ; 
    private static user newuser;
    private static Leave_Request__c leaveRequest;
    private static Leave_Request__c leaveRequest2;
    private static Leave_Request__c leaveRequestOpt1;
    private static Leave_Request__c leaveRequestOpt2;
    private static Leave_Request__c leaveRequestOpt3;
    private static user testUser;
    
    static testMethod void myUnitTest() {
      User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
	System.runAs ( thisUser ) {
		LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
		
     //Project Lead user
        newuser = InitializeTestData.createPLUser();
        newuser.Email = 'pavithra.gajendra@extentor.com';
        Database.insert(newuser); 
        System.debug(newuser);      
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        System.debug(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewServiceSalesOrder=InitializeTestData.createServiceSalesOrder(NewDeal.Id);
        database.insert(NewServiceSalesOrder);
        newproject = InitializeTestData.createProject(NewServiceSalesOrder.id);
        newproject.Project_Lead__c = newuser.Id ;
        database.insert(newproject );
        //Test User
        testUser = InitializeTestData.createUser('testUser@extentor.com');
        testUser.Email = 'pavithra.gajendra@extentor.com';
        Database.insert(testUser);
        //Allocate into project
        newallocation =InitializeTestData.createAllocation(newproject.id,testUser.id);
        Database.insert(newallocation );       
        Date startDate=Date.today();
        Date endDate = startdate.addDays(2);
        leaveRequest=InitializeTestData.createLeaveRequest(testUser.id,startDate,endDate);
        Database.insert(leaveRequest);
        leaveRequestOpt1=InitializeTestData.createLeaveRequest(testUser.id,date.newInstance(date.today().year(),02,16),date.newInstance(date.today().year(),02,16));
        leaveRequestOpt1.Optional_Holiday__c=true;
        Database.insert(leaveRequestOpt1);
        leaveRequestOpt2=InitializeTestData.createLeaveRequest(testUser.id,date.newInstance(date.today().year(),02,17),date.newInstance(date.today().year(),02,17));
        leaveRequestOpt2.Optional_Holiday__c=true;
        Database.insert(leaveRequestOpt2);
        leaveRequest.Status__c='Applied';
        database.update(leaveRequest);
        leaveRequest.Status__c='Cancelled';
        database.update(leaveRequest);
        leaveRequestOpt2.Status__c='Cancelled';
        leaveRequestOpt2.LOP__c=true;
        leaveRequestOpt2.Number_of_Days_LOP__c=2;
        database.update(leaveRequestOpt2);
        leaveRequest.Start_Date__c=date.newInstance(date.today().year(),02,13);
        leaveRequest.End_Date__c=date.newInstance(date.today().year(),02,15);
        Database.update(leaveRequest); 
	}
          
    }
}