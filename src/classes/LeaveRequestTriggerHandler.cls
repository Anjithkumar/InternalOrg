public with sharing class LeaveRequestTriggerHandler{

//-- SINGLETON PATTERN
    private static LeaveRequestTriggerHandler instance;
    public static LeaveRequestTriggerHandler getInstance(){
        if (instance == null) instance = new LeaveRequestTriggerHandler();
          return instance;      
    }
    
    // -- ATTRIBUTES 
     Decimal leaveCount;
    List<Id> liftOfEmployeeIDs = new List<Id>();
    List<Id> projectList = new  List<Id>();
    List<Id> projectLeads = new List<Id>();
    Map<Id,User> userId_User_Map = new Map<Id,User>();
    List<User> listOfUsersToUpdate = new List<User>();
    String[] toAddresses = new String[10]; 
    
    //--CONSTANTS
    public static final Integer OPTIONAL_HOLIDAY_PERMITTED = 2;
   
    
     //-- METHODS 
     
    
    //-- After Insert
    
     public void onAfterInsert(final List<Leave_Request__c> newObjects,final Map<Id, Leave_Request__c> newObjectsMap){
     
     for(Leave_Request__c leaveReq : newObjects)
    {       
        liftOfEmployeeIDs.add(leaveReq.Employee__c);
    }
    
    for(User user: [select Id,Name,Total_Leave__c ,Optional_Holiday_Count__c from User where ID in :liftOfEmployeeIDs ]){
        userId_User_Map.put(user.Id,user);
    }
    
    for(Leave_Request__c leaveRequest : newObjects)
    {
            if(leaveRequest.Status__c=='Applied' && leaveRequest.Optional_Holiday__c==false)
            {
                User leaveUser = userId_User_Map.get(leaveRequest.Employee__c);
                if(leaveUser != null)
                {
                    leaveUser.Total_Leave__c= leaveUser.Total_Leave__c-leaveRequest.Total_Working_days__c;
                    if(leaveUser.Total_Leave__c < 0){
                        leaveUser.Total_Leave__c = 0;
                    }
                    listOfUsersToUpdate.add(leaveUser);
                    leaveCount = leaveRequest.Total_Working_days__c;
                }
                
               SendMailToLeads(leaveUser,leaveRequest);  
            }
           /*else if(lm.Status__c=='Cancelled' && lm.Optional_Holiday__c==false)
            {
                User u = userId_User_Map.get(lm.Employee__c);
                if(u != null)
                {
                    u.Total_Leave__c= u.Total_Leave__c+lm.Total_Working_days__c;
                    
                    listOfUsersToUpdate.add(u);
                    
                    
                }
                
                
                
                
            }*/
            
            else if(leaveRequest.Status__c=='Applied' && leaveRequest.Optional_Holiday__c==true)
            {
                User leaveUser = userId_User_Map.get(leaveRequest.Employee__c);
                if(leaveUser.Optional_Holiday_Count__c<=OPTIONAL_HOLIDAY_PERMITTED)
                {
                    
                    leaveUser.Optional_Holiday_Count__c =leaveUser.Optional_Holiday_Count__c+1;
                    
                    update leaveUser;
                }
                else
                    
                {
                    leaveRequest.addError('Employee cannot apply for more than two optional holidays');
                    
                }
               SendMailToLeads(leaveUser,leaveRequest);   
                
            }
     }
}
//--After Update
      
     public void onAfterUpdate(final List<Leave_Request__c> newObjects,final List<Leave_Request__c> oldObjects,final Map<Id, Leave_Request__c> newObjectsMap,final Map<Id, Leave_Request__c> oldObjectsMap){
     for(Leave_Request__c lm : newObjects)
    {
      if(lm.Status__c=='Applied' && lm.Optional_Holiday__c==false)
            {
                User u = userId_User_Map.get(lm.Employee__c);
                
                
                if(oldObjectsMap.get(lm.id).Start_Date__c != lm.Start_Date__c || oldObjectsMap.get(lm.id).End_Date__c != lm.End_Date__c )
                {
                    u.Total_Leave__c = u.Total_Leave__c+oldObjectsMap.get(lm.id).Total_Working_days__c;
                    System.debug('----------------------------------------'+u.Total_Leave__c);
                    //  u.Total_Leave__c =u.Total_Leave__c+leaveCount;
                    u.Total_Leave__c= u.Total_Leave__c-lm.Total_Working_days__c;
                    if(u.Total_Leave__c < 0){
                        u.Total_Leave__c = 0;
                    }
                    listOfUsersToUpdate.add(u);                  
                }
            }
            
            else if(lm.Status__c=='Cancelled' && lm.Optional_Holiday__c==false)          
            {
                User u = userId_User_Map.get(lm.Employee__c);               
                //if(trigger.oldMap.get(lm.id).Start_Date__c != lm.Start_Date__c || trigger.oldMap.get(lm.id).End_Date__c != lm.End_Date__c )
                if(oldObjectsMap.get(lm.id).Status__c!=lm.Status__c)
                {
                    if(lm.LOP__c){
                        u.Total_Leave__c= u.Total_Leave__c+lm.Total_Working_days__c - lm.Number_of_Days_LOP__c;
                    }
                    else{
                        u.Total_Leave__c= u.Total_Leave__c+lm.Total_Working_days__c;
                    }
                    listOfUsersToUpdate.add(u);                   
                }               
             }

        }
       }
            //--Sending Mail to Leads
            public void SendMailToLeads(User leaveUser,Leave_Request__c leaveRequest){
                 //User allocated projects
                 for(Allocation__c allocation :[SELECT Id,Project__c,Assigned_User__c FROM Allocation__c WHERE Assigned_User__c =: leaveUser.Id]){
                    projectList.add(allocation.Project__c);
                 }
                  //Sending mail to Project leads of the user
                 for(Project__c project : [SELECT id,Project_Lead__c,Project__c.Project_Lead__r.Email FROM Project__c WHERE id IN: projectList AND Status__c='In-Progress']){
                    projectLeads.add(project.Project_Lead__c); 
                    toAddresses.clear(); 
                    toAddresses.add(project.Project_Lead__r.Email);                 
                 }
                  
                  if(projectLeads.isEmpty()){
                  
                  }
                 System.assertEquals(toAddresses,null);
                if((!toAddresses.isEmpty())&&toAddresses!= null){                  
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();          
                mail.setToAddresses(toAddresses); 
                mail.setSubject('Team Member On Leave'); 
                String body = 'Dear, \r\n'+'\r\n'+ leaveUser.Name + ' has applied for leave from '+leaveRequest.Start_Date__c+' to '+leaveRequest.End_Date__c; 
                mail.setPlainTextBody(body); 
                Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail}); 
                }                                  
                }
}