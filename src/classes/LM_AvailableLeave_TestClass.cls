@isTest(SeeAllData=false)
private class LM_AvailableLeave_TestClass{
    private static user testuser;
    private static user testuser2;
    private static user testuser3;
    // private static contact testcontact;
    private static Leave_Request__c testleave;
    // private static List<contact> conts;
    
    
    private static void init()
    {
        
        
        
        
        testuser = InitializeTestData.createUser('user2@testorg.com');
        testuser.Total_Leave__c=21;
        database.insert(testuser);
        
        
        
        //  testcontact = LM_InitializeTestData.createContact('testcontact222',testaccount.id);
        //  database.insert(testcontact);
        
        testleave = InitializeTestData.createLeaveRequest(testuser.id,date.newInstance(date.today().year(),07,01),date.newInstance(date.today().year(),07,05));
        database.insert(testleave);
        
    }
    
    public static user createManagerUser(){ 
        string user_id=userinfo.getUserId();  
        Profile p = [SELECT Id FROM Profile WHERE Name='HR One App User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, Reports_to_ManagerHR__c=user_id,Project_Lead__c=user_id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='test1234543@extentor.com');
        
        
        return u; 
    }
    public static user createManagerUser2(){ 
        string user_id=userinfo.getUserId();  
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, Reports_to_ManagerHR__c=user_id,Project_Lead__c=user_id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='test1543@extentor.com');
        
        
        return u; 
    }
    
    
    private static Testmethod void createLeaveRequest()
    {
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        testuser2=createManagerUser();
        insert testuser2;
        testuser = InitializeTestData.createUser('user3@testorg.com');
        testuser.Total_Leave__c=21;
        database.insert(testuser);
        testuser3=createManagerUser2();
        insert testuser3;
        system.runAs(testuser2){
            pagereference pr=new pagereference('/apex/LM_AvailableLeavePage?name=testcontact222');
            Test.setCurrentPageReference(pr);
                LM_AvailableLeaveClass availableleave=new LM_AvailableLeaveClass();
            availableleave.movetopage();
            availableleave.toggleSort();
            availableleave.runSearch();
        }
        system.runAs(testuser){
            pagereference pr=new pagereference('/apex/LM_AvailableLeavePage?name=testcontact222');
            Test.setCurrentPageReference(pr);
            LM_AvailableLeaveClass availableleave=new LM_AvailableLeaveClass();
            availableleave.movetopage();
            availableleave.soql=null;
            availableleave.toggleSort();
            availableleave.runSearch();
            
        }
        system.runAs(testuser3){
            pagereference pr=new pagereference('/apex/LM_AvailableLeavePage?name=testcontact222');
            Test.setCurrentPageReference(pr);
            LM_AvailableLeaveClass availableleave=new LM_AvailableLeaveClass();
            availableleave.movetopage();
            
            availableleave.toggleSort();
            availableleave.runSearch();
            
        }
        
    }
}