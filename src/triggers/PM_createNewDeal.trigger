trigger PM_createNewDeal on Deal__c (after update) 
{
/* To create new deal 120 days before the contract end date and asigned the newly created deal to the sales head of the organisation 
   
   Author: Ashwin 
   
   Created Date :13/06/2013
   
   Last Modified Date :30/07/2013

   Reason: To add new field on the Deal object 


*/

List<deal__c> listOfnewdeals=new List<deal__c>();

Id salesheadRoleid =[Select id from UserRole where Name='Sales Head' Limit 1].id;

Id salesHeadid =[Select id from User where UserRoleid=:salesheadRoleid Limit 1].id;
User salesHead = [Select email from User where id =:salesHeadid Limit 1]; 


for(deal__c listOfDeals:Trigger.new)
{
 
 deal__c olddeal=trigger.oldMap.get(listOfDeals.id);
     if(listOfDeals.Client_Renewal__c!=olddeal.Client_Renewal__c)
     {
     
     if(listOfDeals.Client_Renewal__c==True && listOfDeals.Deal_Type__c=='Licenses')

      {

            system.debug('**********************INSIDEIF');
            deal__c newdeal = new deal__c(
            Name=listOfDeals.Name+' ContractRenewal',
            Stage__c=listOfDeals.Stage__c,
            Deal_Start_Date__c=listOfDeals.Deal_Start_Date__c,
            Customer__c=listOfDeals.Customer__c,
            RecordTypeId=listOfDeals.RecordTypeId,
            Close_Date__c=System.Today(),
            Amount__c=listOfDeals.Amount__c,
            Email_Notification__c=True,
            OwnerId=salesHeadid


);
           
listOfnewdeals.add(newdeal);

    }
   }
}
insert(listOfnewdeals);

/*if(listOfnewdeals!=null)

{
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 

EmailTemplate et = [SELECT id FROM EmailTemplate WHERE developerName = 'Email_Notification_to_Deal_Owner'];
 String[] toAddresses = new string[] {salesHead.email};
    mail.setToAddresses(toAddresses);
mail.setSenderDisplayName(' Administrator');

mail.setTargetObjectId(listOfnewdeals[0].id); // Specify who the email should be sent to.
mail.setTemplateId(et.id);
 
Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});  

}*/



}