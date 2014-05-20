@isTest(seealldata=false)
private  class LM_Leave_Request_BI_BU_TestClass
{
    private static user testUser;
    private static Leave_Request__c testleave;
    private static Leave_Request__c testleave2; 
    static testMethod void multipleleave ()
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        System.runAs (thisUser) {
            //String extentorAccountid = [Select id from userrole  where name='Developer'  limit 1].id;
            testUser=InitializeTestData.createUser('user5@testorg.com');
            //testUser.UserRoleId=extentorAccountid;
            testUser.Date_of_Joining__c=date.today();
            testUser.Total_Leave__c=21;
            Database.insert(testUser);
        }
        string userid=userinfo.getUserId();
        Date startDate=Date.newInstance(date.today().year(),07,03);
        Date endDate=Date.newInstance(date.today().year(),07,07);
        testleave=InitializeTestData.createLeaveRequest(testUser.id,startDate,endDate);
        database.insert(testleave);
        
        testleave2=InitializeTestData.createLeaveRequest(testUser.id,date.newInstance(date.today().year(),02,16),date.newInstance(date.today().year(),02,17));
        database.insert(testleave2);
        testleave.Start_Date__c=startDate+2;
        testleave.End_Date__c=endDate+2;
        database.update(testleave);
    }
}