@isTest(seeAlldata = true)
private class PM_ScopeController_Testclass {
    private static Customer__c testAccount;
    private static Connection__c testContact;
    private static Deal__c testDeal;
    private static Sales_Order__c testSalesorder;
    private static Project__c  testProject;
    private static scope__c testScope;
    
    Private static void init()
    {
        testAccount=InitializeTestData.createCustomer();
        Database.insert(testAccount);
        testContact=InitializeTestData.createConnection(testAccount.id);
        Database.insert(testContact);
        testDeal=InitializeTestData.createServiceDeal(testAccount.id);
        Database.insert(testDeal);
        testSalesorder=InitializeTestData.createServiceSalesOrder(testDeal.id);
        testSalesorder.Customer__c=testAccount.id;
        Database.insert(testSalesorder);
        testProject=InitializeTestData.createProject(testSalesorder.id);
        Database.insert(testProject);
        testScope=new scope__c();
        testScope.Description__c=null;
        testScope.Related_Project__c=testProject.id;
    }
    private static testMethod void myUnitTest() {
        init();
        ApexPages.StandardController sc = new ApexPages.standardController(testProject);
        // create an instance of the controller
        PM_ScopeController pm= new PM_ScopeController(sc);
        pm.getlistOfScope();
        pm.addNewScope();
        pm.addNewScope();
        database.insert(testScope);
        pm.save();
        String x=ApexPages.CurrentPage().getParameters().put('removeRow', '2');  
        pm.remove();
        String y=ApexPages.CurrentPage().getParameters().put('deleteRow', testScope.id); 
        pm.addNewScope();
        pm.addNewScope();
        pm.remove();
        /*   pm.addNewScope();
        scope__c test1= new scope__c();
        test1.Description__c='';
        test1.Related_Project__c=testProject.id;
        Database.insert(test1);
        delete test1;
        pm.save();
        pm.remove();  */
    }
}