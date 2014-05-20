/*
To create consolidated time sheet record with values from resource forecaste and ticket object
 Author: Ashwin  Extentor
 
 Created Date:4/03/2013

 Last Modified Date: 29/03/2013

 Reason:To copy the currency type from parent salesorder to child salesorder items 
*/

Trigger PM_Consolidated_time_sheet_BI  on Consolidated_Time_Sheet__c (before insert) 
{
    
    for(Consolidated_Time_Sheet__c orderItems :  Trigger.new)
        
    {
        Sales_Order__c  selectedSalesorder =[select RecordType.Name,Billing_Type__c , Project_Category__c,CurrencyIsoCode from  Sales_Order__c where  Id=:orderItems.Sales_Order__c ];
        if(selectedSalesorder.RecordType.name =='Services T&M' && selectedSalesOrder.Billing_Type__c != 'FP'&& selectedSalesOrder.Project_Category__c=='Maintenance' )
        {
            Project__c selectedProject=[Select id,Sales_Order__r.Deal__c from Project__c where Sales_Order__c=:orderItems.Sales_Order__c];
            String dealId = selectedProject.Sales_Order__r.Deal__c;
             
             Ticket__c SelectedTicket= [Select Name,Assigned_User__r.Name,Subject__c from ticket__c where Project__c =:selectedProject.id ][0];
        
            Allocation__c selectedAllocation = [Select id, Assigned_User__r.name, Assigned_User__r.EmployeeNumber,Assigned_User__c ,Project__c ,Role__c from  Allocation__c where Project__c=:selectedProject.id AND Assigned_User__c=:orderItems.userid__c];
            orderItems.name= SelectedTicket.Name+'#'+SelectedTicket.Assigned_user__r.name+'#'+SelectedTicket.Subject__c;
            orderItems.Actual_Date__c=Date.Today();
            orderItems.Planned_Date__c=Date.Today();
            orderItems.Status__c='Completed';
            orderItems.CurrencyIsoCode= selectedSalesorder.CurrencyIsoCode;
            try{
                
               // Resource_Forecast__c selectedResourceForecast = [Select id,Deal__c, Unit_Rate__c,Role__c from Resource_Forecast__c    where Deal__c =:dealId AND Role__c=:selectedAllocation.Role__c ];
                //orderItems.Unit_Rate__c = selectedResourceForecast .Unit_Rate__c;
           }
            catch(Exception e){
                orderItems.addError('One of the project roles does not feature in the resource forecast roles. Hence Sales order item couldn\'t be created');
            }
            
        }
        
        
        else if (selectedSalesorder.RecordType.name =='Services T&M' && selectedSalesOrder.Billing_Type__c != 'FP' && selectedSalesOrder.Project_Category__c !='Maintenance' )
        {
            Project__c selectedProject=[Select id,Sales_Order__r.Deal__c from Project__c where Sales_Order__c=:orderItems.Sales_Order__c];
            String dealId = selectedProject.Sales_Order__r.Deal__c;
            Allocation__c selectedAllocation = [Select id, Assigned_User__r.name, Assigned_User__r.EmployeeNumber,Assigned_User__c ,Project__c ,Role__c from  Allocation__c where Project__c=:selectedProject.id AND Assigned_User__c=:orderItems.userid__c]; 
            orderItems.name= selectedAllocation.Assigned_User__r.name+ '#'+ selectedAllocation.Role__c+ '#'+ selectedAllocation.Assigned_User__r.EmployeeNumber;  
            orderItems.Actual_Date__c=Date.Today();
            orderItems.Planned_Date__c=Date.Today();
            orderItems.Status__c='Completed';
            orderItems.CurrencyIsoCode= selectedSalesorder.CurrencyIsoCode;
            try{
                
                //Resource_Forecast__c selectedResourceForecast = [Select id,Deal__c, Unit_Rate__c,Role__c from Resource_Forecast__c    where Deal__c =:dealId AND Role__c=:selectedAllocation.Role__c ];
                //orderItems.Unit_Rate__c = selectedResourceForecast .Unit_Rate__c;
           }
            catch(Exception e){
                orderItems.addError('One of the project roles does not feature in the resource forecast roles. Hence Sales order item couldn\'t be created');
            }
            
        }
        
    }
    
    
}