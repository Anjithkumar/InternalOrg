global class LM_UpdateLeaveBalance implements Database.Batchable<sObject>{
    global  String ContactList;
    global Database.QueryLocator start(Database.BatchableContext BC){
        if(ContactList==null){
            ContactList='Select id,name, Total_Leave__c,Email from User where Date_of_Joining__c != null';
        }
        //ContactList ='Select id,name, Total_Leave__c from user  where userrole.name=\' Developer\' AND Exit_Date__C= NULL' ;
        return Database.getQueryLocator(ContactList);
    }
    global void execute(Database.BatchableContext BC, List<sObject> Scope){
        LM_CustomSetting__c currentYear = [Select No_Of_Annual_Leaves__c, Frequncy_Of_Run__c from LM_CustomSetting__c where Active__c = true limit 1];
        List<String> monthsToConsider = currentYear.Frequncy_Of_Run__c.split(';');
        List<String> toaddress = new List<String>();
        Decimal noOfDaysToAdd = currentYear.No_Of_Annual_Leaves__c /monthsToConsider.size();
        List<User> contactsToUpdate = new List<User>();
        for(sObject sobjects : scope)
        {
            User SelectedContact =(User)sobjects;
           if(SelectedContact!=null)
           {
           
           
            SelectedContact.Total_Leave__c=SelectedContact.Total_Leave__c+ noOfDaysToAdd ;
            toaddress.add(SelectedContact.Email);
            contactsToUpdate.add(SelectedContact);
           
           } 
           //system.debug(SelectedContact.Total_Leave__c);
            
        }
        update contactsToUpdate;
        
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();   
        mail.setReplyTo('batch@acme.com');
        mail.setSenderDisplayName('HR Manager');
        mail.setSubject('Leaves Cerdited ');
        mail.setPlainTextBody('Leave has been cerdited');
        mail.setHtmlBody('Hi<br/><br/><br/>'+
                         'This mail is to inform you that leave has been cerdited to your leave account'+ 
                         '<br/><br/><br/><br/>'+
                         'Please login to salesforce to know more <br/><br/>'+
                         
                         'Thanks'
                        );  
        mail.setToAddresses(toaddress);  
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    global void finish(Database.BatchableContext BC){
        FeedItem fi= new FeedItem();
        fi.title='Leaves  credited.';
        fi.body='leaves are credited  for this quarter';
        fi.parentid=userinfo.getuserid();
        insert fi;
        
        
    }
}