global class PM_EmailSendUpdate implements Database.Batchable<sObject>{
    
    global  String unSubmittedTimeEntries;
    
    set<String> setOfEmailIds= new set<String>();
    list<String> ListOfMails= new list<String>();
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        if(unSubmittedTimeEntries==null){
            unSubmittedTimeEntries='select id,name,Effort_Put_in_by_User__c,Effort_Put_in_by_User__r.Email,Project__r.Project_Type__c,CreatedDate,Status__c from Time_Entry__c where Project__r.Project_Type__c=\'Client Recoverable\' AND CreatedDate=Last_week  AND Status__c=\'Saved\'';
        }
        
        return Database.getQueryLocator(unSubmittedTimeEntries);
        
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> Scope){
        
        List<String> toaddress = new List<String>();
        for(sObject s: scope){
            Time_Entry__c SelectedTimeEntry=(Time_Entry__c)s;
            setOfEmailIds.add(SelectedTimeEntry.Effort_Put_in_by_User__r.Email);
            system.debug(setOfEmailIds); 
        }
        ListOfMails.addAll(setOfEmailIds);
        Date firstDayOfMonth = System.today().toStartofWeek();
        Date startOfWeek=(firstDayOfMonth -6);
        Date endOfWeek=(firstDayOfMonth -1);
        string startDayOfWeek=startOfWeek.format();
        String endDayOfWeek=endOfWeek.format();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();   
        mail.setReplyTo('batch@acme.com');
        mail.setSenderDisplayName('Time sheet');
        mail.setSubject('Submit Time Sheets for Approval');
        mail.setPlainTextBody('Please submit time sheets for approval');
        mail.setHtmlBody('Hi<br/><br/><br/>'+
                         'This mail is to inform you that your time sheets are not submitted for approval  for the past week['+startDayOfWeek+'-' +endDayOfWeek +']:'+ '<br/>'+
                         'Please submit time sheets ASAP'+
                         ' '+URL.getSalesforceBaseUrl().toExternalForm()+'/apex/PM_TimeEntrySubmissionPage'  + '<br/><br/><br/>'+
                         
                         
                         
                         ' '+ 'Thanks');  
        mail.setToAddresses(ListOfMails);  
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    global void finish(Database.BatchableContext BC){
        
        
        
    }
}