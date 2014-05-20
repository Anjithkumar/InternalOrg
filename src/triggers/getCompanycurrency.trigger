trigger getCompanycurrency on Deal__c (before insert) 
{
Map<String,String>listOfCustomers = new Map<String,String>();
List<Id> customerId = new List<Id> ();
for(Deal__c listOfdeals : Trigger.new)
{
customerId.add(listOfdeals.Customer__c);
}

for(Customer__c listOfcustomer : [Select id,CurrencyIsoCode from Customer__c where id IN : customerId])
{
listOfCustomers.put(listOfcustomer.id,listOfcustomer.CurrencyIsoCode);

}

for(Deal__c updatedDeal : Trigger.new)
{
updatedDeal.CurrencyIsoCode=listOfCustomers.get(updatedDeal.Customer__c);

}



}