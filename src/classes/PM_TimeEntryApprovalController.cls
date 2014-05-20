public class PM_TimeEntryApprovalController {

     /*public PageReference save()
     {
     upsert listOfTimeEntry;
     return null;
     }*/
    
    public String listOfProject{get;set;}
    public String projName{get;set;}
    public Boolean listEmpty{get;set;}
    public Boolean renderSection2{get;set;}
    public List<InnerWrapper> wrapperlist=new List<InnerWrapper>(); 
        
    public List<InnerWrapper> submittedWrapperList=new List<InnerWrapper>();
    public List<Time_Entry__c> listofSubmittedTimeEntries = new List<Time_Entry__c>();
    public List<Time_Entry__c> listOfTimeEntry = new List<Time_Entry__c>();
    
    public PM_TimeEntryApprovalController() {
        listEmpty=true;
    }


    

    //public List<Project__c> listofProjects = new List<Project__c>();
    public OuterWrapper newInstance;
    public class InnerWrapper
    {
        public Time_Entry__c instance{get;set;}
        public Boolean isChecked {get;set;}
        public InnerWrapper(Time_Entry__c t){
            instance = t;
            isChecked = true;
        }
    }
    
    public class OuterWrapper
    {
        public String projInstance{get;set;}
        public List<InnerWrapper> InnerWrapperList{get;set;}
    }
    public List<OuterWrapper> OuterWrapperlist;
    
    InnerWrapper wrapperInstance;
    
    public List<OuterWrapper> getProjectName()
    {
        OuterWrapperlist=new List<OuterWrapper>();
        String checkProjectName='';
        listOfTimeEntry=[select Project__c,Project__r.Name,Related_Task__c,Date__c,Activity_Description__c,Effort__c,Client_Recoverable__c,Effort_Put_in_by_User__c from Time_Entry__c where Status__c='Submitted' AND (Project__r.Project_Lead__c=:UserInfo.getUserId() OR  Project__r.Project_Lead__r.Project_Lead__c=:UserInfo.getUserId()) order by Project__c,Date__c];
        List<InnerWrapper> tempInnerWrapperList = new List<InnerWrapper>();
        for(Time_Entry__c timeEntry:listOfTimeEntry)
        {
            if(timeEntry.Effort_Put_in_by_User__c!=UserInfo.getUserId())
            {
                System.debug(timeEntry.Project__r.Name+' loooooooooooooooooooooooooooooooooooooooooooooooooooooook');
                if(checkProjectName == timeEntry.Project__r.Name)
                {    
                     wrapperInstance=new InnerWrapper(timeEntry);
                    tempInnerWrapperList.add(wrapperInstance);
                    checkProjectName= timeEntry.Project__r.Name;
                }
                else
                {
                    if(checkProjectName == '')
                    {
                        //OuterWrapperlist.add(newInstance);
                        wrapperInstance=new InnerWrapper(timeEntry);
                        tempInnerWrapperList.add(wrapperInstance);
                        checkProjectName = timeEntry.Project__r.Name;
                    }
                    else{
                        newInstance = new OuterWrapper();
                        newInstance.projInstance = checkProjectName ;
                        newInstance.InnerWrapperList = tempInnerWrapperList;
                        OuterWrapperlist.add(newInstance);
                        //system.assertEquals(OuterWrapperlist,null);
                        checkProjectName=timeEntry.Project__r.Name;
                        tempInnerWrapperList = new List<InnerWrapper>();
                        wrapperInstance=new InnerWrapper(timeEntry);
                        tempInnerWrapperList.add(wrapperInstance);
                        //checkProjectName = timeEntry.Project__r.Name;
                    }
                }
            }
          
          
        }
        //last outer wrapper instance
        newInstance = new OuterWrapper();
        newInstance.projInstance = checkProjectName ;
        newInstance.InnerWrapperList = tempInnerWrapperList;
        OuterWrapperlist.add(newInstance);
        if(OuterWrapperlist.size()==0)
        {
            listEmpty=false;
        }
        //system.assertEquals(OuterWrapperlist,null);
        return OuterWrapperlist;
    }
    
    
    
    public PageReference approve()
    {
        projName=Apexpages.currentPage().getParameters().get('projName');
        listofSubmittedTimeEntries = new List<Time_Entry__c>();
        for(OuterWrapper iterator:OuterWrapperlist)
        {
            
            if(iterator.projInstance==projName)
            {
                submittedWrapperList=iterator.InnerWrapperList;
                break;
            }
        }

        for(InnerWrapper iterator:submittedWrapperList)
        {

            if(iterator.IsChecked==true)
            {
                listofSubmittedTimeEntries.add(iterator.instance);
            }
        } System.debug(listofSubmittedTimeEntries+' eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ');        
        for(Time_Entry__c iterator:listofSubmittedTimeEntries)
        {
            //System.debug('in');
            iterator.Status__c = 'Approved';
            iterator.Approval_Date__c = Date.today();
        }
        database.update(listofSubmittedTimeEntries);
        
        OuterWrapperList.clear();
        submittedWrapperList.clear();
        newInstance=null;
                 //System.debug(listofSubmittedTimeEntries);
                 //System.debug(submittedWrapperList);
        
        //renderSection2=true;
        return null;
    }
      public PageReference reject()
    {
        projName=Apexpages.currentPage().getParameters().get('projName');
        listofSubmittedTimeEntries = new List<Time_Entry__c>();
        for(OuterWrapper iterator:OuterWrapperlist)
        {
            
            if(iterator.projInstance==projName)
            {
                submittedWrapperList=iterator.InnerWrapperList;
                break;
            }
        }
        
        for(InnerWrapper iterator:submittedWrapperList)
        {

            if(iterator.IsChecked==true)
            {
                listofSubmittedTimeEntries.add(iterator.instance);
            }
        }System.debug(listofSubmittedTimeEntries+' ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');     
        for(Time_Entry__c iterator:listofSubmittedTimeEntries)
        {
            iterator.Status__c = 'Rejected';
            iterator.Approval_Date__c = Date.today();
           
        }
        database.update(listofSubmittedTimeEntries); 
        
        OuterWrapperList.clear();
        submittedWrapperList.clear();
        newInstance=null;
        return null;
    }
   public List<InnerWrapper> getsubmittedRows()
    {
        return submittedWrapperList;
    }


}