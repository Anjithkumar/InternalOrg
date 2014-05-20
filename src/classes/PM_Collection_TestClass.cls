@isTest(seeAlldata = true)
private class PM_Collection_TestClass
{
    static testmethod void checkCollectionPage()
    {
        Test.startTest();
        Receipt__c newReceipt = new Receipt__c();
        newReceipt.Amount__c=123423242;
        PageReference pg = new PageReference('/apex/PM_CollectionPage');
        Test.setCurrentPageReference(pg);
        ApexPages.StandardController sc = new ApexPages.standardController(newReceipt);
        PM_CollectionPageController controller=new PM_CollectionPageController(sc);
        controller.dispFields();
        Test.stopTest();
        
    }    
    static testmethod void checkCollectionPageCHEQUE()
    {
        Test.startTest();
        Receipt__c newReceipt = new Receipt__c();
        newReceipt.Amount__c=123423242;
        newReceipt.Payment_Mode__c = 'Cheque';
        PageReference pg = new PageReference('/apex/PM_CollectionPage');
        Test.setCurrentPageReference(pg);
        ApexPages.StandardController sc = new ApexPages.standardController(newReceipt);
        PM_CollectionPageController controller=new PM_CollectionPageController(sc);
        controller.dispFields();
        Test.stopTest();
    }
    static testmethod void checkCollectionPageCASH()
    {
        Test.startTest();
        Receipt__c newReceipt = new Receipt__c();
        newReceipt.Amount__c=123423242;
        newReceipt.Payment_Mode__c = 'Cash';
        PageReference pg = new PageReference('/apex/PM_CollectionPage');
        Test.setCurrentPageReference(pg);
        ApexPages.StandardController sc = new ApexPages.standardController(newReceipt);
        PM_CollectionPageController controller=new PM_CollectionPageController(sc);
        controller.dispFields();
        Test.stopTest();
    }      
    static testmethod void checkCollectionPageBANKTRANSFER()
    {
        Test.startTest();
        Receipt__c newReceipt = new Receipt__c();
        newReceipt.Amount__c=123423242;
        newReceipt.Payment_Mode__c = 'Bank Transfer';
        PageReference pg = new PageReference('/apex/PM_CollectionPage');
        Test.setCurrentPageReference(pg);
        ApexPages.StandardController sc = new ApexPages.standardController(newReceipt);
        PM_CollectionPageController controller=new PM_CollectionPageController(sc);
        controller.dispFields();
        Test.stopTest();
    }   
}