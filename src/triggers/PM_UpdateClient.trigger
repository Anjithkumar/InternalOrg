trigger PM_UpdateClient on Deal__c (after insert,after update) 
{
List<Id> listOftcustomerIDs = new List<Id>();
Map<String,Customer__c> mapOfcustomers = new Map<String,Customer__c> ();
List<Customer__c> listOfupdatedcustomers =new List<Customer__c>();
 
 for(Deal__c listOfddeal : Trigger.new)
 {
 listOftcustomerIDs.add(listOfddeal.Customer__c);
 
 }
 
 for(Customer__c listOfcustomers : [select id from Customer__c where id IN :listOftcustomerIDs])
 {
 mapOfcustomers.put(listOfcustomers.id , listOfcustomers);
 
 }
 
 for(Deal__c listOfdeals : Trigger.new)
 {
 
 If(listOfDeals.Stage__c=='Closed Won')
 {
 
 Customer__c updateCustomer = mapOfcustomers.get(listOfdeals.Customer__c);
  updateCustomer.Client__c= true;
  listOfupdatedcustomers.add(updateCustomer);
  
  }
  else 
  {
  Customer__c updateCustomers = mapOfcustomers.get(listOfdeals.Customer__c);
  updateCustomers.Client__c=false;
  listOfupdatedcustomers.add(updateCustomers);
  
  }
  
  }
  update listOfupdatedcustomers;
  
  }