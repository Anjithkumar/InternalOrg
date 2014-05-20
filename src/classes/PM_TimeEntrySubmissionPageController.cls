public class PM_TimeEntrySubmissionPageController {
    
    public Boolean renderSection{get;set;}
    public String selectedTab{get;set;}
    public Boolean renderSection2{get;set;}
    public Date weekStart{get;set;}
    public Date weekending{get;set;}
    public String startOfWeek{get;set;}
    public String endOfWeek{get;set;}
    //public Date enteredDate{get;set;}
    Date userEnteredDate;
    public Time_Entry__c timeEntry{get;set;}
    
    private final Time_Entry__c timeEntryRecord;
    public List<EntryWrapper> wrapperlist=new List<EntryWrapper>(); 
    public List<EntryWrapper> submittedWrapperList=new List<EntryWrapper>();
    public List<Time_Entry__c> listofSubmittedTimeEntries;
    public List<Time_Entry__c> listOfTimeEntry{get;set;}
    public String originalSOQL = '';
    static String soql = 'select Id,Activity_Description__c,Name,Project__c,Related_Task__c,Date__c,Effort__c from Time_Entry__c';
    
    
    public PM_TimeEntrySubmissionPageController(ApexPages.StandardController controller) 
    {
        this.timeEntryRecord=(Time_Entry__c)controller.getRecord();
        timeEntry = new Time_Entry__c();
        originalSOQL='select Id,Activity_Description__c,Name,Project__c,Related_Task__c,Date__c,Effort__c from Time_Entry__c';
        //selectedTab = 'name1';
        //System.assertEquals(soql,''); 
    }
    
    public ApexPages.StandardSetController con {
        get {
            
            if(con == null) 
            {
                //system.assertEquals(originalSOQL, null);
                //System.debug(soql);
                /* userEnteredDate = timeEntryRecord.Date__c;
weekstart=userEnteredDate.toStartofWeek()+1;

weekending=userEnteredDate.toStartofWeek()+7;
//System.assertEquals(weekstart,weekending);
string startMonth,endMonth,startDay,endDay = '';
if(weekstart.month() < 9){
startMonth = '0'+weekstart.month();
}
else{
startMonth = weekstart.month().format();
}
if(weekending.month() < 9){
endMonth= '0'+weekending.month();
}
else{
endMonth = weekending.month().format();
}


if(weekstart.day() < 9){
startDay = '0'+weekstart.day();
}
else{
startDay = weekstart.day().format();
}
if(weekending.day() < 9){
endDay= '0'+weekending.day();
}
else{
endDay = weekending.day().format();
}
startOfWeek = weekstart.year() + '-' + startMonth + '-' + startDay;
endOfWeek = weekending.year() + '-' + endMonth + '-' + endDay; */
                try{
                    system.debug(soql+'my soql');
                    con = new ApexPages.StandardSetController(Database.getQueryLocator(soql));
                }
                catch(Exception e){
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'No Time Entries For The Week. Please Choose a Valid Week.');
                    ApexPages.addMessage(myMsg);
                    return null;
                }
                //selectedTab = 'name1';
                // sets the number of records in each page set
                //con.setPageSize(5);
            }
            return con;
        }
        set;
    }
    
    public class EntryWrapper
    {
        public Time_Entry__c instance{get;set;}
        public Boolean isChecked{get;set;}
    }
    
    public PageReference next()
    {
        //System.assertEquals('in','not');
        userEnteredDate = timeEntryRecord.Date__c;
        weekstart=userEnteredDate.toStartofWeek()+1;
        
        weekending=userEnteredDate.toStartofWeek()+7;
        //System.assertEquals(weekstart,weekending);
        string startMonth,endMonth,startDay,endDay = '';
        if(weekstart.month() <= 9){
            startMonth = '0'+weekstart.month();
        }
        else{
            startMonth = weekstart.month().format();
        }
        if(weekending.month() <= 9){
            endMonth= '0'+weekending.month();
        }
        else{
            endMonth = weekending.month().format();
        }
        
        
        if(weekstart.day() <= 9){
            startDay = '0'+weekstart.day();
        }
        else{
            startDay = weekstart.day().format();
        }
        if(weekending.day() <= 9){
            endDay= '0'+weekending.day();
        }
        else{
            endDay = weekending.day().format();
        }
        startOfWeek = weekstart.year() + '-' + startMonth + '-' + startDay;
        endOfWeek = weekending.year() + '-' + endMonth + '-' + endDay;
        soql='select Id,Activity_Description__c,Name,Project__c,Related_Task__c,Date__c,Effort__c from Time_Entry__c where Status__c!=\'Submitted\' AND Status__c!=\'Approved\' AND Date__c>='+ startOfWeek +' AND Date__c<='+ endOfWeek +' AND Effort_Put_in_by_User__c= \''+UserInfo.getUserId()+'\' order by Date__c';
        //System.assertEquals(soql,''); 
        con=null;
        try{
            listOfTimeEntry = (List<Time_Entry__c>)con.getRecords();
            System.debug(listOfTimeEntry+'my list of time entries');
        }
        catch(Exception e){
            
            //ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.FATAL, 'my error msg');
            //ApexPages.addMessage(myMsg1);
            return null;
        }
        for(Time_Entry__c timeEntry: listOfTimeEntry )
        {
            EntryWrapper wrapperInstance=new EntryWrapper();
            wrapperInstance.instance=timeEntry;
            wrapperlist.add(wrapperInstance);
            
        }
        renderSection=true;
        selectedTab = 'name2';
        return null;
        
    }
    public List<EntryWrapper> getTableValues()
    {         
        return wrapperlist;
    }
    
    public PageReference submitRows()
    {
        listofSubmittedTimeEntries = new List<Time_Entry__c>();
        for(EntryWrapper iterator:wrapperlist)
        {
            if(iterator.isChecked==true)
            {
                
                submittedWrapperList.add(iterator);
                listofSubmittedTimeEntries.add(iterator.instance);
                
            }
        }
        //System.debug(listofSubmittedTimeEntries);
        //System.debug(submittedWrapperList);
        
        renderSection2=true;
        selectedTab = 'name3';
        return null;
    }
    public List<EntryWrapper> getsubmittedRows()
    {
        
        return submittedWrapperList;
    }
    public PageReference submit()
    {
        //RecordType recordId = [select Id,Name from RecordType where SobjectType = 'Time_Entry__c' and Name = 'Read Only'];
        //System.debug(listofSubmittedTimeEntries);
        String messageBody;
        String URLaddress;
        String emailAddress;
        Set<Id> setOfProjectId = new Set<Id>();
        List<Id> listOfLeadId = new List<Id>();
        List<Project__c> listOfProject = new List<Project__c>();
        List<User> listofProjectLead = new List<User>();
        for(Time_Entry__c iterator:listofSubmittedTimeEntries)
        {
            iterator.Status__c = 'Submitted';
            iterator.Submission_Date__c = Date.today();
            setOfProjectId.add(iterator.Project__c);
        }
        listOfProject = [select Name,Project_Lead__c,Project_Lead__r.Email,Project_Lead__r.Project_Lead__r.Email from Project__c where Id IN:setOfProjectId];
        
        for(Project__c instance:listOfProject )
        {
            //System.debug(instance.Project_Lead__r.Email);
            List<String> toAddresses = new List<String>();
            Messaging.SingleEmailMessage notificationMail = new Messaging.SingleEmailMessage();
            if(instance.Project_Lead__c!=UserInfo.getUserId())
            {
                emailAddress=(String)instance.Project_Lead__r.Email;
            }
            else 
            {
                emailAddress=(String)instance.Project_Lead__r.Project_Lead__r.Email;
            }
            toAddresses.add(emailAddress);
            notificationMail.setToAddresses(toAddresses);
            notificationMail.setSubject('Time Entries waiting for Approval');
            URLaddress = System.URL.getSalesforceBaseUrl().toExternalForm()+'/apex/PM_TimeEntryApprovalPage?Id='+UserInfo.getUserId();
            messageBody='<html><body>Hi  <br/><br/>This mail is to inform that you have Time Entries waiting for Approval.<br></br>Click on the link to Approve/Reject:<br/><br/><br/><br/><br/><br/><br/><br/><body></html>'+URLaddress ;
            notificationMail.setHtmlBody(messageBody);
            notificationMail.setSaveAsActivity(true);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { notificationMail});  
            
        }
        
        database.update(listofSubmittedTimeEntries);
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Time Entries Submitted For Approval');
        ApexPages.addMessage(myMsg);
        return null;
    }
    
    /*public PageReference toggleSort() 
        {
        wrapperlist.clear();
        //
        con = null;
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        soql = originalSOQL.split('order')[0] + ' order by ' + sortField + ' ' + sortDir ;
        system.debug(soql);
        next();
        return null;
        }
        
        public String sortField 
        {
        get  { if (sortField == null) {sortField = 'Name'; } return sortField;}
        set;
        }

        public String sortDir 
        {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
        }*/
    
    
}