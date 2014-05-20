public class PM_BasicTimeEntryController 
{
    String soqlvar = '';
    
    Time_Entry__c newTimeEntryInstance{get;set;}
    public Boolean RecentTimeEntryBlock{get;set;}
    
    
    public PM_BasicTimeEntryController () {
        soqlVar = 'select Project__r.Name,Related_Task__r.Name,Activity_Type__c,Activity_Description__c,Date__c,Effort__c,Effort_Put_in_by_User__r.Name,Task_Complexity__c,Client_Recoverable__c from Time_Entry__c where Effort_Put_in_by_User__c=  \'' + UserInfo.getUserId() + '\' order by Date__c desc';
        
        //TimeSheetUserId = ApexPages.currentPage().getParameters().get('id');
            //conName = new Contact();
            //conName = [Select id, Name from Contact where id=:TimeSheetUserId];
            //timeEntryRecordsDummy = new List<Time_Entry__c>();
            //dateInDateFormate = date.today();
    }
    
    
    
    
    public Time_Entry__c getNewInstance() 
    {
        newTimeEntryInstance = new Time_Entry__c ();
        return newTimeEntryInstance;
    }
    public PageReference saveStandardTimeEntry() 
    {
        if(newTimeEntryInstance.Project__c==null||newTimeEntryInstance.Related_Task__c==null||newTimeEntryInstance.Date__c == null||newTimeEntryInstance.Effort__c==null||newTimeEntryInstance.Effort__c==0.0)
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Project, Related Task, Effort and Date are mandatory fields. Please fill those to Save a Time Entry Record');
            ApexPages.addMessage(myMsg);
        }
        else
        {
            newTimeEntryInstance.Effort_Put_in_by_User__c = UserInfo.getUserId();
            insert newTimeEntryInstance;
            RecentTimeEntryBlock = true;
        }
        con = null;
        ApexPages.Message myMsg=new ApexPages.Message(ApexPages.Severity.Confirm, 'Your Record Has Been Saved');
        ApexPages.addMessage(myMsg);
        return null;
    }
    public List<Time_Entry__c> getRecentItems() 
    {
        List<Time_Entry__c> listOfRecentTimeEntries = new List<Time_Entry__c>();
        soqlVar = 'select Project__r.Name,Related_Task__r.Name,Activity_Type__c,Activity_Description__c,Date__c,Effort__c,Effort_Put_in_by_User__r.Name,Task_Complexity__c,Client_Recoverable__c from Time_Entry__c where Effort_Put_in_by_User__c=  \'' + UserInfo.getUserId() + '\' order by Date__c desc';
        listOfRecentTimeEntries = (List<Time_Entry__c>)con.getRecords();
        return listOfRecentTimeEntries ;
    }
    public ApexPages.StandardSetController con 
    {
        get 
        {
            if(con == null) 
            {
                //system.assertEquals(soqlvar, null);
                con = new ApexPages.StandardSetController(Database.getQueryLocator(soqlvar));
                // sets the number of records in each page set
                con.setPageSize(5);
            }
            return con;
        }
        set;
    }
    public Boolean hasNext 
    {
        get 
        {
            return con.getHasNext();
        }
        set;
    }
 
    // indicates whether there are more records before the current page set.
   public Boolean hasPrevious 
    {
        get 
        {
        if(con!=null)
            return con.getHasPrevious();
        else return false;
        }
        set;
    }
 
    // returns the page number of the current page set
    public Integer pageNumber 
    {
        get 
        {
            return con.getPageNumber();
        }
        set;
    }
 
    // returns the first page of records
    public void first() 
    {
        con.first();
    }
 
    // returns the last page of records
    public void last() 
    {
        con.last();
    }
 
    // returns the previous page of records
    public void previous() 
    {
        con.previous();
    }
 
    // returns the next page of records
    public void next() 
    {
        con.next();
    }

    
    
}