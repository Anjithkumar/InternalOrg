trigger PM_Sales_Order_AU on Sales_Order__c (after update) 
{
/*
To update the status of consolidated time sheets and salesorder items to "Closed invoice " when the status of salesorder becomes "closed invoice " 

Author: Ashwin 

Created Date:19/02/2013

Last Modified Date :25/03/2012

Reason: To add comments 

*/


public List<Sales_Order_Item__c> UpdatedSalesOrderitems = new List<Sales_Order_Item__c>();


public List<Consolidated_Time_Sheet__c> UpdatedConsolidatedTimeSheets = new List<Consolidated_Time_Sheet__c>();
//public List<Sales_Order_Item__c> SelectedSalesOrderitems = new List<Sales_Order_Item__c>();


List<Id> SalesOrderId = new List<Id>();
List<Id> SalesOrderIdConsolidated = new List<Id>();

for(Sales_Order__c SelectedSalesOrder:Trigger.New)

{
if(SelectedSalesOrder.Status__c=='Closed - Invoiced' && SelectedSalesOrder.Billing_Type__c=='FP' )


{
SalesOrderId.add(SelectedSalesOrder.id);
}

else if (SelectedSalesOrder.Status__c=='Closed - Invoiced' && SelectedSalesOrder.Billing_Type__c=='T&M')

{
SalesOrderIdConsolidated.add(SelectedSalesOrder.id);
}


}


if(SalesOrderId.size()!=0)
{

  for(Sales_Order_Item__c  updateSalesOrderItems :[Select Status__c from Sales_Order_Item__c where Sales_Order__c IN : SalesOrderId ] )
{
updateSalesOrderItems.Status__c='Closed - Invoiced';
UpdatedSalesOrderitems.add(updateSalesOrderItems);
 
} 

update(UpdatedSalesOrderitems);
}

else if(SalesOrderIdConsolidated.size()!=0)
{
for(Consolidated_Time_Sheet__c updateConsolidatedTimeSheets :[Select Status__c from Consolidated_Time_Sheet__c where Sales_Order__c IN :SalesOrderIdConsolidated ] )
{
updateConsolidatedTimeSheets.Status__c='Closed - Invoiced';
UpdatedConsolidatedTimeSheets.add(updateConsolidatedTimeSheets);
 
} 
update(UpdatedConsolidatedTimeSheets);
}





}