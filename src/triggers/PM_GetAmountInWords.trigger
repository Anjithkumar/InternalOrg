trigger PM_GetAmountInWords on Invoice__c (before update, after insert,after update) {
  
  Map<id,Invoice__c> Invoice_Map = new Map<id,Invoice__c>();
  List<id>  SalesorderId_list = new List<id>();
  List<Project__c> ProjectInstance = new List<Project__c>();
  List<Project__c> Project_List ;

 for(Invoice__c invoiceInstance :  Trigger.new)
 {
         if(Trigger.isUpdate && Trigger.isBefore){
     invoiceInstance.Amount_In_Words__c  = PM_Trigger_UtilityClass.generateText(invoiceInstance.Id);
     System.debug(PM_Trigger_UtilityClass.generateText(invoiceInstance.Id));
     }
     
     if(Trigger.isAfter){
     Invoice_Map .put(invoiceInstance.Sales_order__c,invoiceInstance);
     SalesorderId_list.add(invoiceInstance.Sales_order__c);
     }
     
     }
     
     if(SalesorderId_list!=null){
     Project_List = [select name, Sales_Order__c,Actual_Revenue__c from Project__c where Sales_order__c=:SalesorderId_list];
   }
   
   for(Invoice__c inv : Trigger.new){
   for(Project__c project : Project_List){
   if(Project_List.size()>0 && Invoice_Map!= null){
   Project__c pro = new Project__c();
   pro.Actual_Revenue__c = Invoice_Map.get(inv.Sales_Order__c).Total_Invoice_Amount__c;
   pro.id = project.id;
   ProjectInstance.add(pro);
   }
 }
 }
 if(ProjectInstance.size()>0){
 Database.update(ProjectInstance);
 }
 
}