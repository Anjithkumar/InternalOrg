/* Batch Class to carry forward leave balance to next year */

global class LM_LeaveCarryForwardToNextYear implements Database.Batchable<sObject>
{
               global  String ContactList;
      
   
   global Database.QueryLocator start(Database.BatchableContext BC){
       system.debug('...........enter into loop');
      ContactList='Select id,name, Total_Leave__c from User where Date_of_Joining__c != null AND IsActive= true';
      // ContactList='Select id,name, Total_Leave__c from User where userrole.name=\' Developer\' AND Exit_Date__C= NULL';
                  return Database.getQueryLocator(ContactList);
              }

   global void execute(Database.BatchableContext BC, List<sObject> Scope){
                  
                 List<User> contactsToUpdate = new List<User>();
                  LM_CustomSetting__c currentYear = [Select Frequncy_Of_Run__c,No_Of_Annual_Leaves__c,No_of_leaves_to_be_carry_forward__c from LM_CustomSetting__c where Active__c = true limit 1];
                 for(sObject sobjects : scope){
                    
                              User SelectedContactList =(User)sobjects;
                              if(SelectedContactList.Total_Leave__c>=currentYear.No_of_leaves_to_be_carry_forward__c){
                              
                              SelectedContactList.Total_Leave__c=currentYear.No_of_leaves_to_be_carry_forward__c;
                              contactsToUpdate.add(SelectedContactList);
                               }
                      }
                       
                       
                   update contactsToUpdate;
            }
            
     global void finish(Database.BatchableContext BC){
               
               
           }
}