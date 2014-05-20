global class PM_ConsolidatedTimeSheets_FP {
    
    public Boolean refreshPage{get;set;}
    public Boolean WholePage{get;set;}
    public String selectedValue{get;set;}
    Public Consolidated_Time_Sheet__c SelectedSalesOrderItems; 
    Public List<Consolidated_Time_Sheet__c> FetchSalesOrderItems{get;set;}
    
    Public Sales_Order__c  SelectedSalesOrder {get;set;}
    id salesOrderId ;
    Public PM_ConsolidatedTimeSheets_FP (ApexPages.StandardController controller)
    {
        salesOrderId=ApexPages.currentPage().getParameters().get('id');
        SelectedSalesOrder=[Select name,id from Sales_Order__c where id=:salesOrderId AND RecordType.name='Service Type' AND Billing_Type__c='FP'];
        
        resetQueries();
    }
    
    public void resetQueries()
    {
        
        
        FetchSalesOrderItems=[Select Name,Actual_Date__c,Actual_Milestone_Revenue__c,Milestone_Reference_Number__c,Planned_Date__c,Planned_Milestone_Revenue__c,Sales_Order__c,Status__c,Unit_Rate__c  from Consolidated_Time_Sheet__c where Sales_Order__c =:salesOrderId]; 
        
    }
    
    public Consolidated_Time_Sheet__c  getSalesOrderitems(){
        SelectedSalesOrderItems = new Consolidated_Time_Sheet__c();
        //SelectedSalesOrderItems =[Select Assigned_User__c,Role__c,Sales_Order__c,Start_Date__c, Location__c,Percentage__c,End_Date__c from Consolidated_Time_Sheet__c where Sales_Order__c =:SelectedSalesOrder.id ];
        return SelectedSalesOrderItems;
    } 
    
    
    public pageReference Add()
    {
        try{
            
            SelectedSalesOrderItems.Sales_Order__c=salesOrderId;
            //SelectedSalesOrderItems.Planned_Date__c=Date.Today();
            //SelectedSalesOrderItems.Actual_Date__c=Date.Today();
            database.insert(SelectedSalesOrderItems);
            SelectedSalesOrderItems = new Consolidated_Time_Sheet__c();
            
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
    
    /*public PageReference remove() {

Consolidated_Time_Sheet__c ClearAllocation =new Consolidated_Time_Sheet__c();


return null;*/
    
    
    
    
    public PageReference remove2() 
    {
        //system.assertEquals('in','here');
        selectedValue=ApexPages.currentPage().getParameters().get('removeRow');
        
        Consolidated_Time_Sheet__c DeleteSalesOrderItems=new Consolidated_Time_Sheet__c(Id=selectedValue);
        delete DeleteSalesOrderItems ;
        resetQueries();
        return null;
        
    }
}