@isTest(seeAlldata = false)
private class PM_GenerateSOPDF_TestClass
{
    static User testUser;
    static Customer__c testCompany;
    static Deal__c testDeal;
    static Deal_Item__c testDealItem1;
    static Deal_Item__c testDealItem2;
    static Sales_Order__c testSalesOrder;
    
    public static void init()    
    {
        
        LM_CustomSetting__c custominstance= new LM_CustomSetting__c();
        custominstance.name='testing';
        custominstance.Active__c=true;
        custominstance.No_Of_Annual_Leaves__c=21;
        custominstance.Frequncy_Of_Run__c='1;4;7;9';
        insert custominstance;
        
        
        
        testUser=InitializeTestData.createUser('user15@testorg.com');
        testUser.EmployeeNumber = '1234234344';
        database.insert(testUser);
        testCompany=InitializeTestData.createCustomer();
        testCompany.Name='ClientCompany';
        database.insert(testCompany);
        testDeal=InitializeTestData.createLicenseDeal(testCompany.Id);
        database.insert(testDeal);
        testSalesOrder=InitializeTestData.createLicenseSalesOrder(testDeal.Id,testCompany.Id);
        database.insert(testSalesOrder);
        
    }
    static testmethod void generatecheckSO()
    {
        init();
        Test.startTest();
        String isCheck = PM_Generate_and_Attach_SO_PDF1.Generate(testSalesOrder.Id);
        System.assertEquals(isCheck,'success');
        Test.stopTest();
    }
}