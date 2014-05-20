trigger PM_Ticket_AU on Ticket__c (before update,after update ) 
{
    
    /*Author:Sachin
Created Date:
Last Modified on:28/03/2013
Reason for Modification:Naming Convention
*/
    
    //This is a map kept ready to store the userIds and their associated names
    Map<id,String> mapIdNames = new Map<id,String>();
    
    list<Project_Task__c> createProjecttask = new list<Project_Task__c>();
    list<Ticket__c> TESTticket = new list<Ticket__c>();
    //A Set to store the userIds
    Set<Id> userIds = new Set<Id>();
    
    List<Id> ticketIds = new List<Id>();
    
    //Retrieving the details from the Ticket records.
    
    for(Ticket__c newTicket:trigger.new)
    {
        
        TESTticket.add(newTicket);
        
    }
    
    
    
    if(Trigger.isBefore)
    {
        for(Ticket__c newTicket:trigger.new)
        {
            if(newTicket.Assigned_User__c!=null && newTicket.Project__c !=null)
            {
                
              newTicket.Status__c='Assigned';
            }
        }
    }
    if(Trigger.isAfter)
    {

        for(Ticket__c newTicket:trigger.new)
        {  
            
            
            if(newTicket.Assigned_User__c!=null && newTicket.Project__c !=null)
            {
                
                
                Ticket__c ticketCheckOld = trigger.oldMap.get(newTicket.id);       
                if((ticketCheckOld.Assigned_User__c)!=(newTicket.Assigned_User__c))
                {
                    
                    userIds.add(newTicket.Assigned_User__c);
                    ticketIds.add(newTicket.id);
                    
                }
            }
            
        }
        
        for(User retrievedUser :[select id,Name From user where id IN : userIds ])
        {
            mapIdNames.put(retrievedUser .Id,retrievedUser .Name); 
        }
        
        //if(Trigger.isUpdate)
        
        
        for(Ticket__c ticketCheckNew:[Select name, id,Assigned_User__c, Project__c from Ticket__c where Id IN : ticketIds]  )
        {
            
            
            String userName = mapIdNames.get(ticketCheckNew.Assigned_User__c);
            Project_Task__c projectTask = new Project_Task__c(Name=ticketCheckNew.Name+'#'+userName,Project__c=ticketCheckNew.Project__c,
                                                              Ticket__c=ticketCheckNew.id); 
            createProjecttask.add(projectTask);
        
        }
        insert(createProjecttask);
    }
    
    
    
}