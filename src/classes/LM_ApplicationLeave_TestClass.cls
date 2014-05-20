@isTest(SeeAllData=false)
private class LM_ApplicationLeave_TestClass{
    private static user testuser=[select id from user where id=:userinfo.getUserId()];
    private static Leave_Request__c testleave;
    private static void init(){
        // testuser = InitializeTestData.createUser();
        // testuser= new user();
        testuser.Date_of_Joining__c=Date.today();
        testuser.Total_Leave__c=21;
        //testuser.Project_Lead__c=userinfo.getUserId();
        //testuser.Reports_to_ManagerHR__c=userinfo.getUserId();
        database.update(testuser);   
        apexpages.currentpage().getParameters().put('conid',userinfo.getuserid());
        testleave=InitializeTestData.createLeaveRequest(userinfo.getUserId(), date.newInstance(date.today().year(),03,02), date.newInstance(date.today().year(),03,03));
        testleave.Project_Lead__c=userinfo.getUserId();
        database.insert(testleave); 
    }
    private static Testmethod void createLeaveRequest(){
        init();
        /*PageReference pg = new PageReference('/apex/LM_ApplicationLeavePage?conid='+userinfo.getuserid());
        Test.setCurrentPageReference(pg);
        Apexpages.StandardController sc = new Apexpages.standardController(testLeave);
        LM_ApplicationLeaveClass applicationLeaveClasscontroller = new LM_ApplicationLeaveClass(sc); 
        
        Test.StartTest();
        
        applicationLeaveClasscontroller.getLeave();
        applicationLeaveClasscontroller .save();
        
        Test.StopTest();*/
        
        PageReference pg = new PageReference('/apex/LM_ApplicationLeavePage?conid='+userinfo.getuserid());
        Test.setCurrentPageReference(pg);
        Apexpages.StandardController sc = new Apexpages.standardController(testLeave);
        LM_ApplicationLeaveClass applicationLeaveClasscontroller = new LM_ApplicationLeaveClass(sc); 
        Leave_Request__c testRecord = applicationLeaveClasscontroller.getLeave();
        testRecord = InitializeTestData.createLeaveRequest(userinfo.getuserid(),date.newInstance(date.today().year(),07,01),date.newInstance(date.today().year(),07,14));
        applicationLeaveClasscontroller.leaveRequestRecord = testRecord;
        applicationLeaveClasscontroller.save();
        
        
        
    }
}