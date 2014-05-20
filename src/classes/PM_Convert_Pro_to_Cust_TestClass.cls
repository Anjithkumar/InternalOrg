@isTest(seeAlldata=false)
private  class PM_Convert_Pro_to_Cust_TestClass
{
    private static Customer__c testlead;
    private static Customer__c testaccount;
    private static Connection__c testcontact;
    private static Deal__c testservicedeal;
    private static Deal__c testlicensedeal;
    
    private static void init(){
        testlead=InitializeTestData.createProspect();
        database.insert(testlead);
    }
    private static testMethod void convert(){
        init();
        PageReference pg = new PageReference('apex/PM_Convert_Prospects_To_Customers?id='+testlead.Id);
        Test.setCurrentPageReference(pg);
        PM_Convert_Prospects_To_Customers testobj=new PM_Convert_Prospects_To_Customers();
        Test.startTest();
        testobj.CreateServiceOpp=true;
        testobj.save();
        testobj.CreateLicenseOpp=true;
        testobj.save();
        testobj.hideDealTable();
        testobj.showDealTable();
        testobj.cancel();
        system.assertequals(null,testobj.hideDealTable());
        Test.stopTest();
    }
}