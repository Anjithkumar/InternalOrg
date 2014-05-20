Public Class PM_CreateConsolidatedTimeSheets
{
    /*
To Create Consolidated Time sheets

Author : Ashwin & Sharath Extentor 

Created Date: 6/03/2012

Last Modified : 24/03/2013

Reason : To add comments


*/
    public String selectedValue{get;set;}
    Public String salesOrderId;
    public Boolean renderfullBlock{get;set;}
    public Boolean renderSection{get;set;}
    public Boolean renderSection2{get;set;}
    public Boolean renderSection3{get;set;}
    public Boolean renderSection4{get;set;}
    Public List<Wrapper> wrapperlist =new List<Wrapper>(); 
    Public Set<Wrapper> submittedWrapperList=new Set<Wrapper>();
    Public Project__c selectedProject;
    Public List<Time_Entry__c> selectedEntries;
    
    public List<Time_Entry__c> listofSubmittedTimeEntries = new List<Time_Entry__c>();
    public Set<Time_Entry__c> addedTimeEntriesSet = new Set<Time_Entry__c>();
    Public List<User> selectedUserId = new List<User>();
    
    //Controller 
    public PM_CreateConsolidatedTimeSheets() 
    {
        salesOrderId=ApexPages.CurrentPage().getParameters().get('id');
        // try{
        selectedProject=[Select id,Billing_Cycle__c from Project__c where Sales_Order__c=:salesOrderId];
        /* }
catch(Exception e){
ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'No project created yet for the SalesOrder');
ApexPages.addMessage(myMsg);
return;
}*/
        try{
            selectedEntries=[Select Effort_Put_in_by_User__c,Project__c,Date__c,Submission_Date__c, Status__c, Approval_Date__c from Time_Entry__c where Project__c =:selectedProject.id AND Status__c='Approved'AND Client_Recoverable__c=True order by Effort_Put_in_by_User__c limit 1  ];//AND CreatedDate = THIS_MONTH];  
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'No time entries for this project in approved status found ');
            ApexPages.addMessage(myMsg);
            return;
        }     
    }
    
    Set<Id> selectedTimeEntryIds  = new Set<Id>();
    
    public ApexPages.StandardSetController con {
        
        get {
            if(con == null) 
            {
                //try{
                
                selectedProject=[Select id, Sales_Order__c,Billing_Cycle__c from Project__c where Sales_Order__c=:ApexPages.CurrentPage().getParameters().get('id')];
                con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Effort_Put_in_by_User__c, Effort__c,Project__c,Date__c,Submission_Date__c, Status__c, Approval_Date__c from Time_Entry__c where Project__c =:selectedProject.id AND Status__c='Approved' AND Client_Recoverable__c=True and ID not IN :selectedTimeEntryIds order by Effort_Put_in_by_User__c  ]));
                // sets the number of records in each page set
                con.setPageSize(5);  
                
                /* }
catch (Exception e) 
{
ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'No project created yet for the SalesOrder');
ApexPages.addMessage(myMsg);
return null;

}*/
                
            }
            
            
            return con;
        }
        set;
    }
    
    public class Wrapper
    {
        public Time_Entry__c instance{get;set;}
        public Boolean isChecked{get;set;}
    }
    //To get the time entries and add into wrapper list
    public List<Wrapper> getTableValues()
    {         
        try
        {
            wrapperlist.clear();
            for(Time_Entry__c timeEntry: (List<Time_Entry__c>)con.getRecords())//[Select Effort_Put_in_by_User__c,Effort__c,Project__c,Date__c,Submission_Date__c, Status__c, Approval_Date__c from Time_Entry__c where Project__c =:selectedProject.id AND Status__c='Approved' order by Effort_Put_in_by_User__c,Date__c  ])
            {
                if(!addedTimeEntriesSet.contains(timeEntry)){
                    Wrapper wrapperInstance=new Wrapper();
                    wrapperInstance.instance=timeEntry;
                    wrapperlist.add(wrapperInstance);  
                } 
            }
        }catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPAges.Severity.FATAL, e.getMessage()));
        }
        return wrapperlist;
    }
    
    
    
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
    
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        
        
        get {
            
            
            return con.getHasPrevious();
            
        }
        set;
    }
    
    
    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
    
    // returns the first page of records
    public void first() {
        con.first();
    }
    
    // returns the last page of records
    public void last() {
        con.last();
    }
    
    // returns the previous page of records
    public void previous() {
        con.previous();
    }
    
    // returns the next page of records
    public void next() {
        con.next();
    }
    
    // returns the PageReference of the original page, if known, or the home page.
    public void cancel() {
        con.cancel();
    }  
    
    //To get the submitted time entries
    public List<Wrapper> getsubmittedRows()
    {
        List<Wrapper> returnList = new List<Wrapper>();
        returnList.addAll(submittedWrapperList);
        return returnList;
    }
    
    Map<String,Decimal> userEffortsMap = new Map<String,Decimal>();
    
    
    
    public PageReference AddItems() 
    {
        for(Wrapper iterator:wrapperlist)
        {
            if(iterator.isChecked==true)
            { 
                if(!addedTimeEntriesSet.contains(iterator.instance)){
                    submittedWrapperList.add(iterator);
                    addedTimeEntriesSet.add(iterator.instance);
                    selectedTimeEntryIds.add(iterator.instance.Id);
                }
            }           
            
        }
        con = null;
        return null;
    }
    
    List<Consolidated_Time_Sheet__c> listofSalesOrderItems = new List<Consolidated_Time_Sheet__c>();
    public PageReference create()
    {
        String prevUser = null;
        
        Decimal effortHoursPerUser = 0;
        try{
            for(Wrapper iterator:submittedWrapperList)//wrapperlist)
            {
                if(iterator.isChecked==true)
                { 
                    
                    if(prevUser == null)
                    {
                        prevUser = iterator.instance.Effort_Put_in_by_User__c;
                        effortHoursPerUser = iterator.instance.Effort__c;
                    }
                    else if(prevUser == iterator.instance.Effort_Put_in_by_User__c)
                    {
                        prevUser = iterator.instance.Effort_Put_in_by_User__c;
                        effortHoursPerUser = effortHoursPerUser + iterator.instance.Effort__c;
                    }
                    else if(prevUser != iterator.instance.Effort_Put_in_by_User__c)
                    {
                        //add prev user's efforts into a map
                        userEffortsMap.put(prevUser,effortHoursPerUser);
                        effortHoursPerUser = 0;
                        prevUser = iterator.instance.Effort_Put_in_by_User__c;
                        effortHoursPerUser = iterator.instance.Effort__c;
                    }
                    
                }
            }
            //add last user's details into map
            userEffortsMap.put(prevUser,effortHoursPerUser);
        }catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPAges.Severity.FATAL, e.getMessage()));
        }
        listofSubmittedTimeEntries.addAll(addedTimeEntriesSet);
        for(String userSelected :userEffortsMap.keySet())
        {
            Consolidated_Time_Sheet__c NewSalesOrderItem = new Consolidated_Time_Sheet__c();
            
            NewSalesOrderitem.Sales_Order__c=selectedProject.Sales_Order__c;
            NewSalesOrderitem.UserId__c=userSelected;
            NewSalesOrderItem.Quantity__c = userEffortsMap.get(userSelected);
            listofSalesOrderItems.add(NewSalesOrderitem);
        }
        try{
            insert listofSalesOrderItems;
        }catch(Exception e)
        {
            //ApexPages.addMessage(new ApexPages.Message(ApexPAges.Severity.FATAL, e.getMessage()));
            return null;
        }
        for(Time_Entry__c iterator:listofSubmittedTimeEntries) 
        {
            iterator.Status__c = 'Processed';
        }
        database.update(listofSubmittedTimeEntries);
        listofSubmittedTimeEntries.clear();
        system.debug('--------------------------------------------********Working');
        PageReference pg = new PageReference('/' +salesOrderId );
        return pg;
        
    }
    
    //To Delete the submitted time entries
    public PageReference remove()
    {
        String rowToRemove =ApexPages.currentPage().getParameters().get('removeRow');
        for(Wrapper w :submittedWrapperList)
        {
            if(w.instance.Id == rowToRemove)
            {
                submittedWrapperList.remove(w);
                selectedTimeEntryIds.remove(w.Instance.Id);
                addedTimeEntriesSet.remove(w.Instance);
                con = null;
            }
        }
        
        return null;
    }
    //To uncheck the selected time entries
    public PageReference reset()
    {
        submittedWrapperList.clear();
        listofSubmittedTimeEntries.clear();
        selectedTimeEntryIds.clear();
        addedTimeEntriesSet.clear();
        con = null;
        return null;
    }
    //return to salesorder detail page
    public PageReference goback()
    {
        PageReference pg = new PageReference('/' +salesOrderId );
        return pg;
        
    }
    
}