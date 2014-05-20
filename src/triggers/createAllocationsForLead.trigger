trigger createAllocationsForLead on Project__c (after insert) {

  for(Project__c newPro:Trigger.new)
  {
      
          Allocation__c all=new Allocation__c();
          all.Assigned_User__c=newPro.Project_Lead__c;
          all.Project__c=newPro.id;
          all.Start_Date__c=newPro.Actual_Start_Date__c;
          all.End_Date__c =newPro.Actual_End_Date__c;
          all.Location__c=newPro.Project_Type__c;   
          all.Role__c='Project Lead';
          insert all; 
          
      
  }
}