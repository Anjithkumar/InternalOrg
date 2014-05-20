trigger PM_ToGetCustomerName on Sales_Order__c (before insert,before update) 
{
for(Sales_Order__c CurrentSalesOrder : Trigger.new)
{
if(CurrentSalesOrder.Deal__c!=null)
{
Deal__c SelectedDeal = [Select id, Customer__c,CurrencyIsoCode from Deal__c where id=:CurrentSalesOrder.Deal__c][0];


CurrentSalesOrder.Customer__c=SelectedDeal.Customer__c;
CurrentSalesOrder.CurrencyIsoCode=SelectedDeal.CurrencyIsoCode;

}




}
}