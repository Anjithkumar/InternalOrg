@isTest
private class LM_User_BI_TestClass {
    private static user testUser;
    
    
    static testMethod void myUnitTest() {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        System.runAs (thisUser) {
            // String extentorAccountid = [Select id from userrole  where name='Developer'  limit 1].id;
            testUser=InitializeTestData.createUser('user9@testorg.com');
            // testUser.UserRoleId=extentorAccountid;
            testUser.Date_of_Joining__c=date.today();
            Database.insert(testUser);
        }
        custominstance.Frequncy_Of_Run__c='0';
        database.update(custominstance);
        System.runAs (thisUser) {
            // String extentorAccountid = [Select id from userrole  where name='Developer'  limit 1].id;
            testUser=InitializeTestData.createUser('user10@testorg.com');
            testUser.UserName='testtrigger@extentor.com';
            // testUser.UserRoleId=extentorAccountid;
            testUser.Date_of_Joining__c=date.today();
            Database.insert(testUser);
        }
    }
}