@isTest(seeAlldata = true)
private class PM_updateOnTaxAmount_TestClass {
    
    public static Invoice__c  testInvoice;
    public static Invoice_Line_Item__c  testInvoiceItem;
    
    static testMethod void myUnitTest() {
        testInvoice=InitializeTestData.createInvoice();
        testInvoice.Tax_Code__c='ST;VAT';
        testInvoice.Tax_Percent__c='10;12';
        Database.insert(testInvoice);
        
        testInvoiceItem=InitializeTestData.createInvoiceLineItem(testInvoice.id);
        Database.insert(testInvoiceItem);
        
    }
}