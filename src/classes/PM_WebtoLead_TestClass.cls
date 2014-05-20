@isTest(seeAlldata=false)
private class PM_WebtoLead_TestClass {
    private static Customer__c testAccount;
    private static Customer__c testAccount2;
    
    private static testMethod void webToLead() {
        
        testAccount=InitializeTestData.createProspect();
        database.insert(testAccount);
        ApexPages.StandardController sc = new ApexPages.standardController(testAccount);
        PM_WebtoLead pm= new PM_WebtoLead(sc);
        pm.save();
        pm.cancel();
    }
    //Testing exception scenarios.
    private static testMethod void webToLead2() {
        
        testAccount2=InitializeTestData.createProspect();
        ApexPages.StandardController sc = new ApexPages.standardController(testAccount2);
        PM_WebtoLead pm= new PM_WebtoLead(sc);
        pm.save();
        pm.cancel();
    }
}