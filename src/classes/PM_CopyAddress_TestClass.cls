@isTest(seeAlldata = true)
private  class PM_CopyAddress_TestClass
{
    private static Customer__c testaccount;
    private static testMethod void copyAddress(){
        testaccount =InitializeTestData.createCustomer();
        database.insert(testaccount);
        
        testaccount.Billing_Address_To_Shipping_Address__c=true;
        database.update(testaccount);
        System.assertEquals(true, testaccount.Billing_Address_To_Shipping_Address__c);
        
    }
}