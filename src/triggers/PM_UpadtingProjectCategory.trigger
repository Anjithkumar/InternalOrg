/*
To copy the project category from project to salesorder 

Author : Ashwin kc 

Created date :15/3/2013

Modified date :4/1/2013

Reason : Changing naming convention 

*/
trigger PM_UpadtingProjectCategory on Project__c (after insert ,after update) 

{
    map<Id,String> SalesOrdermap = new map<Id ,String>();
    List<Id> SalesOrderId = new List<Id>(); 
    List<Sales_Order__c > UpdatedSalesOrderitems = new List<Sales_Order__c >();
    String ProjectCategory;
    for(Project__c newprojects : Trigger.New)
    {
        
        if(newprojects.Sales_Order__c!=null)
        {
            
            SalesOrderId.add(newprojects.Sales_Order__c);
            //ProjectCategory=newprojects.Project_Category__c;
            SalesOrdermap.put(newprojects.Sales_Order__c,newprojects.Project_Category__c);
            
        }
    }
    for(Sales_Order__c SelectedSalesOrder :[Select id from Sales_Order__c where Id =:SalesOrderId])
    {
        //SelectedSalesOrder.Project_Category__c = ProjectCategory;
        SelectedSalesOrder.Project_Category__c =SalesOrdermap.get(SelectedSalesOrder.Id);
        UpdatedSalesOrderitems.add(SelectedSalesOrder);
        
    }
    update UpdatedSalesOrderitems;
    
    
    
    
    
    
}