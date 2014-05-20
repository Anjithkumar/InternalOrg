global class PM_CreateSalesOrderItems {
    /* 
To Create the salesorder items for the fixed price salesorder 

Author:Ashwin Extentor 

Created date : 13/02/2013

Modification date :29/03/2013

Reason :To copy the currency type from parent salesorder to child salesorder items 



*/
    public Boolean refreshPage{get;set;}
    public Boolean WholePage{get;set;}
    public String selectedValue{get;set;}
    Public Sales_Order_Item__c SelectedSalesOrderItems; 
    Public List<Sales_Order_Item__c> FetchSalesOrderItems{get;set;}
    
    Public Sales_Order__c  SelectedSalesOrder {get;set;}
    id salesOrderId ;
    Public PM_CreateSalesOrderItems(ApexPages.StandardController controller)
    {
        salesOrderId=ApexPages.currentPage().getParameters().get('id');
        SelectedSalesOrder=[Select name,id ,CurrencyIsoCode from Sales_Order__c where id=:salesOrderId AND RecordType.name='Service Type' AND Billing_Type__c='FP'];
        
        resetQueries();
    }
    
    public void resetQueries()
    {
        
        
        FetchSalesOrderItems=[Select Name,Actual_Date__c,Actual_Milestone_Revenue__c,Milestone_Reference_Number__c,Planned_Date__c,Planned_Milestone_Revenue__c,Sales_Order__c,Status__c,Unit_Rate__c  from Sales_Order_Item__c where Sales_Order__c =:salesOrderId]; 
        
    }
    
    public Sales_Order_Item__c  getSalesOrderitems(){
        SelectedSalesOrderItems = new Sales_Order_Item__c();
        //SelectedSalesOrderItems =[Select Assigned_User__c,Role__c,Sales_Order__c,Start_Date__c, Location__c,Percentage__c,End_Date__c from Sales_Order_Item__c where Sales_Order__c =:SelectedSalesOrder.id ];
        return SelectedSalesOrderItems;
    } 
    
    
    public pageReference Add()
    {
        try{
            
            SelectedSalesOrderItems.Sales_Order__c=salesOrderId;
            
            SelectedSalesOrderItems.CurrencyIsoCode= SelectedSalesOrder.CurrencyIsoCode;
            //SelectedSalesOrderItems.Planned_Date__c=Date.Today();
            //SelectedSalesOrderItems.Actual_Date__c=Date.Today();
            database.insert(SelectedSalesOrderItems);
            SelectedSalesOrderItems = new Sales_Order_Item__c();
            
            resetQueries();
            
        }
        catch (Exception ex) {
            ApexPages.addMessages(ex);
            system.debug(ex);
            
        }
        return null;
    }
    
    
    
    public PageReference QuickSave() 
    {
        update FetchSalesOrderItems ;
        
        return null;
    }
    
    
    
    public PageReference remove() 
    {
        //system.assertEquals('in','here');
        selectedValue=ApexPages.currentPage().getParameters().get('removeRow');
        
        Sales_Order_Item__c DeleteSalesOrderItems=new Sales_Order_Item__c(Id=selectedValue);
        delete DeleteSalesOrderItems ;
        resetQueries();
        return null;
        
    }
}