trigger PM_updateOnTaxAmount on Invoice_Line_Item__c (before insert,before update) {
    List<Invoice_Line_Item__c > listOfInvoiceLineItems = new List<Invoice_Line_Item__c >();
    List<id> listOfInvoiceIds=new List<id>();
    List<invoice__c> listOfNewInvoice=new List<invoice__c>();
    List<String> taxPercent;
    List<Decimal> taxPercentages= new List<Decimal>();
    Decimal percent;
    Decimal totalPercentages=0;
    
    for(Invoice_Line_Item__c newInvoiceLineItem:Trigger.new){
        listOfInvoiceIds.add(newInvoiceLineItem.Invoice__c);
    }
    
    
    for(Invoice__c listOfInvoices:[select id,Amount__c,Tax_Percent__c from Invoice__c where id IN:listOfInvoiceIds]){
        taxPercent=listOfInvoices.Tax_Percent__c.split(';');
    }
    
    
    for(Integer i=0; i<taxPercent.size(); i++){
        percent=Decimal.valueOf(taxPercent[i]);
        taxPercentages.add(percent);
    }
    
    for(Integer i=0;i<taxPercentages.size();i++){
        totalPercentages+=taxPercentages[i];
    }
    for(Invoice_Line_Item__c newInvoiceLineItem:Trigger.new){
        newInvoiceLineItem.Invoice_LineItem_Tax_Amount__c=(totalPercentages/100)*newInvoiceLineItem.Amount__c;
    }
}