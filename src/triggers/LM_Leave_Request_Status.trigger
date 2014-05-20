trigger LM_Leave_Request_Status on Leave_Request__c (after insert,after update) 
{
    LeaveRequestTriggerHandler handler = LeaveRequestTriggerHandler.getInstance();
  //-- After Update
    if (Trigger.isUpdate && Trigger.isAfter) {        
        handler.onAfterUpdate(Trigger.new, Trigger.old,Trigger.newMap,Trigger.oldMap);
    } else   
      
    // -- After Insert      
    if (Trigger.isInsert && Trigger.isAfter) {        
        handler.onAfterInsert(Trigger.new,Trigger.newMap);
    } 
         
}