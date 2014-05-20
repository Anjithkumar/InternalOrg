@isTest(seeAlldata=false)
private class PM_Ticket_LoginController_Testclass {
    private static Customer__c testAccount;
    private static Connection__c testContact;
    private static Ticket__c testTicket;
    
    //UN & PWD fields are required.
    static testMethod void ticketLogin() {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        testContact=InitializeTestData.createConnection(testAccount.id);
        testContact.user_name__c='sat12@ext.com';
        testContact.Password__c='1234567';
        Database.insert(testContact);
        testTicket= InitializeTestData.createTicket();
        testTicket.Connection__c=testContact.id;
        Database.insert(testTicket);
        ApexPages.StandardController sc = new ApexPages.standardController(testTicket);
        PM_Ticket_LoginController ticketInstance= new PM_Ticket_LoginController(sc);
        ticketInstance.login(); //UN&PWD fields are required
    }
    
    // not aregistered user.
    static testMethod void notRegisteredUser() {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        testContact=InitializeTestData.createConnection(testAccount.id);
        testContact.user_name__c='sat12@ext.com';
        testContact.Password__c='1234567';
        Database.insert(testContact);
        testTicket= InitializeTestData.createTicket();
        testTicket.Connection__c=testContact.id;
        Database.insert(testTicket);
        ApexPages.StandardController sc = new ApexPages.standardController(testTicket);
        PM_Ticket_LoginController ticketInstance= new PM_Ticket_LoginController(sc);
        ticketInstance.UserName='sa12t1@ext.com';
        ticketInstance.Password='1234567';
        ticketInstance.login(); 
    }
    
    
    //Invalid login credentials
    static testMethod void invalidLogin() {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        testContact=InitializeTestData.createConnection(testAccount.id);
        testContact.user_name__c='sat12@ext.com';
        testContact.Password__c='1234567';
        Database.insert(testContact);
        testTicket= InitializeTestData.createTicket();
        testTicket.Connection__c=testContact.id;
        Database.insert(testTicket);
        ApexPages.StandardController sc = new ApexPages.standardController(testTicket);
        PM_Ticket_LoginController ticketInstance= new PM_Ticket_LoginController(sc);
        ticketInstance.UserName='sat12@ext.com';
        ticketInstance.Password='123456789';
        ticketInstance.login(); 
    }
    
    //Login Sucessfull. 
    static testMethod void loginSucess() {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        testContact=InitializeTestData.createConnection(testAccount.id);
        testContact.user_name__c='sat12@ext.com';
        testContact.Password__c='1234567';
        Database.insert(testContact);
        testTicket= InitializeTestData.createTicket();
        testTicket.Connection__c=testContact.id;
        Database.insert(testTicket);
        ApexPages.StandardController sc = new ApexPages.standardController(testTicket);
        PM_Ticket_LoginController ticketInstance= new PM_Ticket_LoginController(sc);
        ticketInstance.UserName='sat12@ext.com';
        ticketInstance.Password='1234567';
        ticketInstance.login();
        
    }
    
    //Saving attachment  and file
    static testMethod void savingFile() {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        testContact=InitializeTestData.createConnection(testAccount.id);
        testContact.user_name__c='sat12@ext.com';
        testContact.Password__c='1234567';
        Database.insert(testContact);
        testTicket= InitializeTestData.createTicket();
        testTicket.Connection__c=testContact.id;
        Database.insert(testTicket);
        ApexPages.StandardController sc = new ApexPages.standardController(testTicket);
        PM_Ticket_LoginController ticketInstance= new PM_Ticket_LoginController(sc);
        ticketInstance.UserName='sat12@ext.com';
        ticketInstance.Password='1234567';
        ticketInstance.login();
        ticketInstance.attachFile(); 
        ticketInstance.Attach=Blob.valueOf('Unit Test Attachment Body');
        ticketInstance.contenttype ='.pdf';
        ticketInstance.fileName='Test Name';
        ticketInstance.save();
        ticketInstance.cancel();
    }
    
    
    //Saving attachment With error and file
    static testMethod void savingFileWithBug() {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        testContact=InitializeTestData.createConnection(testAccount.id);
        testContact.user_name__c='sat12@ext.com';
        testContact.Password__c='1234567';
        Database.insert(testContact);
        testTicket= InitializeTestData.createTicket();
        testTicket.Connection__c=testContact.id;
        Database.insert(testTicket);
        ApexPages.StandardController sc = new ApexPages.standardController(testTicket);
        PM_Ticket_LoginController ticketInstance= new PM_Ticket_LoginController(sc);
        ticketInstance.UserName='sat12@ext.com';
        ticketInstance.Password='1234567';
        ticketInstance.login();
        ticketInstance.attachFile(); 
        ticketInstance.Attach=Blob.valueOf('Unit Test Attachment Body');
        ticketInstance.contenttype ='.pdf';
        ticketInstance.fileName=null;
        ticketInstance.save();
        ticketInstance.cancel();
    }
    
    /*
        //  ticketInstance.UserName='sa12t@ext.com';
        //  ticketInstance.Password='1234567';
        // ticketInstance.con.User_Name__c='sat@ext.com';
        //ticketInstance.con.Password__c='12345';
        ticketInstance.UserName='sat@ext.com';
        ticketInstance.Password='123456';
        ticketInstance.login();//loggedin with correct username and password.
        ticketInstance.Attach=Blob.valueOf('Unit Test Attachment Body');
        ticketInstance.contenttype ='.pdf';
        ticketInstance.fileName='testname';
        //ticketInstance.save(); //save the attachment.
        ticketInstance.UserName='sat12@ext.com';
        ticketInstance.Password='123456';
        ticketInstance.login();// not aregistered user
        ticketInstance.UserName='sat@ext.com';
        ticketInstance.Password='123456789';
        ticketInstance.login();// Invalid credentials
        ticketInstance.cancel(); 

// }*/
}