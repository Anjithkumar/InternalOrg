public class PM_WeeklyView_v5_4 
{

    public PageReference closeStandardSection() {
    StandardTimeEntrySection = false;
        return null;
    }


    public List<Time_Entry__c> getRecentItems() {
    List<Time_Entry__c> listOfRecentTimeEntries = [select Project__c,Project__r.Name,Related_Task__r.Name,Activity_Type__c,Task_Complexity__c,Client_Recoverable__c,Activity_Description__c,Related_Task__c,Effort_Put_In_by_User__c,Date__c,Effort__c from Time_Entry__c where Effort_Put_In_by_User__c=:UserInfo.getUserId() order by CreatedDate desc limit 10];
        return listOfRecentTimeEntries ;
    }


    


    public PageReference saveStandardTimeEntry() {
    
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
    //System.debug(RecentTimeEntryBlock +'hereeeeeeeeeeeeeee' );
        return null;
    }

    Time_Entry__c newTimeEntryInstance{get;set;}
    public Time_Entry__c getNewInstance() {
         newTimeEntryInstance = new Time_Entry__c ();
         //RecentTimeEntryBlock = true;
         return newTimeEntryInstance;
    }


    public PageReference standardTimeEntrySection() 
    {
        StandardTimeEntrySection = true;
        return null;
    }


   

public String selectedTab { get; set; }
    
    public PageReference Done() {
    PageReference pg = new PageReference('/home/home.jsp');
        return pg;
    }

   
    public Integer pcounter{get;set;}
    public String projectIdValue{get;set;}
    public String taskIdValue {get;set;}
    public String effortValue{get;set;}
    public String dateValue{get;set;}
    public String activityDescription{get;set;}
    public String projCounter{get;set;}
    public Boolean clientrecoverable{get;set;}
    public List<String> datesOfWeek {get;set;}
    public Boolean StandardTimeEntryLink{get;set;}
    public Boolean StandardTimeEntrySection{get;set;}
    public Boolean RecentTimeEntryBlock{get;set;}
    
   
   public PM_WeeklyView_v5_4()
   {
       inputDateString = date.today().format();
       
   }
    
    public PageReference saveTimeEntryRecord()
    {

        try
        {
            
            Time_Entry__c timentr = [select Id,Effort__c,Activity_Description__c,Client_Recoverable__c from Time_Entry__c where Project__c =:projectIdValue AND Related_Task__c =:taskIdValue AND Date__c =:date.parse(dateValue) AND Effort_Put_In_by_User__c =:UserInfo.getUserId()];
            timentr.Effort__c = Decimal.valueOf(effortValue);
            timentr.Activity_Description__c = activityDescription;
            
            timentr.Client_Recoverable__c= Boolean.valueOf(clientrecoverable);
            database.update(timentr);
            System.debug(pcounter+'Hello');
        }
        catch(Exception e)
        {
           
            Time_Entry__c newTimeEntry = new Time_Entry__c();
            newTimeEntry.Project__c = projectIdValue;
            newTimeEntry.Related_Task__c = taskIdValue ;
            newTimeEntry.Effort__c = Decimal.valueOf(effortValue);
            newTimeEntry.Effort_Put_In_by_User__c = UserInfo.getUserId();
            newTimeEntry.Date__c = date.parse(dateValue);
            newTimeEntry.Activity_Description__c = activityDescription;
            newTimeEntry.Client_Recoverable__c= Boolean.valueOf(clientrecoverable);
            newTimeEntry.Status__c = 'Saved';
            database.insert(newTimeEntry);
        }
   
    return null;
    }
    
    
    
    public List<Project__c> listOfProject;
    public List<Project_Task__c> listOfProjectTask;
    public List<Time_Entry__c> listOfTimeEntry; 
    public Date inputDate{get;set;}
    public String inputDateString{get;set;}
    public Boolean showPanel{get;set;}
    public Date startOfWeek{get;set;}
    public Date endOfWeek{get;set;}
    
    
    public class InnerWrapper 
    {
        public Project_Task__c projTask{get;set;}
        public List<Time_Entry__c> timeEntryList{get;set;}
        public Id projId{get;set;}
    }
    public class OuterWrapper 
    {
        public Project__c projInstance{get;set;}
        public List<InnerWrapper> inList{get;set;}
        public Integer counter{get;set;}
    }
    
    
    public List<OuterWrapper> getAllDetails()
    {
        if(pcounter==null) 
        {
        pcounter = 0;
        }
        if(projCounter!=null)
         {pcounter = Integer.valueOf(projCounter);}
        listOfProject = [select Id,Name from Project__c where Status__c = 'In-Progress'  AND Id IN(select Project__c from Allocation__c where Assigned_User__c=:UserInfo.getUserId()) order by Name];
        listOfProjectTask = [select Id,Name,Project__c,Project__r.Name from Project_task__c where Project__c In:listOfProject order by Project__c];
        String Name = '';
        OuterWrapper instance1;
        List<Time_Entry__c> listofAllTimeEntries = new List<Time_Entry__c>();
        List<OuterWrapper> projNInList = new List<OuterWrapper>();
        InnerWrapper instance = new InnerWrapper();
        List<InnerWrapper> taskNTimeEntryList = new List<InnerWrapper>();
        
        for(Project_Task__c ptloop:listOfProjectTask)
        {      
                
            instance = new InnerWrapper();
            instance.projTask = new Project_Task__c();
            instance.timeEntryList = new List<Time_Entry__c>();
            startOfWeek = inputDate.toStartOfweek();
            endOfWeek = inputDate.toStartOfweek().addDays(6);
            Time_Entry__c day= new Time_Entry__c(Project__c=ptloop.Project__c,Related_Task__c=ptloop.Id,Effort__c=null,Effort_Put_In_by_User__c=UserInfo.getUserId(),Date__c=startOfWeek);
            Time_Entry__c day1= new Time_Entry__c(Project__c=ptloop.Project__c,Related_Task__c=ptloop.Id,Effort__c=null,Effort_Put_In_by_User__c=UserInfo.getUserId(),Date__c=startOfWeek.addDays(1));
            Time_Entry__c day2= new Time_Entry__c(Project__c=ptloop.Project__c,Related_Task__c=ptloop.Id,Effort__c=null,Effort_Put_In_by_User__c=UserInfo.getUserId(),Date__c=startOfWeek.addDays(2));
            Time_Entry__c day3= new Time_Entry__c(Project__c=ptloop.Project__c,Related_Task__c=ptloop.Id,Effort__c=null,Effort_Put_In_by_User__c=UserInfo.getUserId(),Date__c=startOfWeek.addDays(3));
            Time_Entry__c day4= new Time_Entry__c(Project__c=ptloop.Project__c,Related_Task__c=ptloop.Id,Effort__c=null,Effort_Put_In_by_User__c=UserInfo.getUserId(),Date__c=startOfWeek.addDays(4));
            Time_Entry__c day5= new Time_Entry__c(Project__c=ptloop.Project__c,Related_Task__c=ptloop.Id,Effort__c=null,Effort_Put_In_by_User__c=UserInfo.getUserId(),Date__c=startOfWeek.addDays(5));
            Time_Entry__c day6= new Time_Entry__c(Project__c=ptloop.Project__c,Related_Task__c=ptloop.Id,Effort__c=null,Effort_Put_In_by_User__c=UserInfo.getUserId(),Date__c=startOfWeek.addDays(6));

            //listOfTimeEntry = [select Id,Date__c,Effort__c,Effort_Put_in_By_User__c,Effort_Put_in_By_User__r.Name,Project__c,Related_Task__c,Related_Task__r.Name from Time_Entry__c where Related_Task__c=:ptloop.Id AND Date__c>=:startOfWeek AND Date__c<=:endOfWeek order by Related_Task__c];
            for(Time_Entry__c teloop:[select Id,Date__c,Effort__c,Activity_Description__c,Client_Recoverable__c,Effort_Put_in_By_User__c,Effort_Put_in_By_User__r.Name,Project__c,Related_Task__c,Related_Task__r.Name from Time_Entry__c where Related_Task__c=:ptloop.Id AND Effort_Put_in_By_User__c=:UserInfo.getUserId() AND Date__c>=:startOfWeek AND Date__c<=:endOfWeek order by Related_Task__c])
            {
               
                if(teloop.Effort__c!=null)
                {
                    //day1= new Time_Entry__c(Project__c=ptloop.Project__c,Related_Task__c=ptloop.Id,Effort__c=null,Effort_Put_In_by_User__c=UserInfo.getUserId(),Date__c=startOfWeek.addDays(1));
                    if(startOfWeek.daysBetween(teloop.Date__c)==0)
                    {
                        day = teloop;
                    }
                    else if(startOfWeek.daysBetween(teloop.Date__c)==1)
                    {
                        day1 = teloop;
                    }
                    else if(startOfWeek.daysBetween(teloop.Date__c)==2)
                    {
                        day2 = teloop;
                    }
                    else if(startOfWeek.daysBetween(teloop.Date__c)==3)
                    {
                        day3 = teloop;
                    }
                    else if(startOfWeek.daysBetween(teloop.Date__c)==4)
                    {
                        day4 = teloop;
                    }
                    else if(startOfWeek.daysBetween(teloop.Date__c)==5)
                    {
                        day5 = teloop;
                    }
                    else if(startOfWeek.daysBetween(teloop.Date__c)==6)
                    {
                        day6 = teloop;
                    }
                }
            }
            listofAllTimeEntries.add(day);
            listofAllTimeEntries.add(day1);
            listofAllTimeEntries.add(day2);
            listofAllTimeEntries.add(day3);
            listofAllTimeEntries.add(day4);
            listofAllTimeEntries.add(day5);
            listofAllTimeEntries.add(day6);
            
            instance.projTask = ptloop;
            
            instance.timeEntryList = listofAllTimeEntries;
            listofAllTimeEntries = new List<Time_Entry__c>();
            instance.projId = ptloop.Project__c;
            taskNTimeEntryList.add(instance);
        }
        Integer rowCounter = 0;
        for(InnerWrapper iterator:taskNTimeEntryList)
        {
            if(Name==''||Name!=iterator.projId)
            {
                if(Name!='')
                {
                    projNInList.add(instance1);
                }
               instance1 = new OuterWrapper();
               instance1.counter = rowCounter++;
               instance1.projInstance = new Project__c();
               instance1.projInstance = [select Name,Id from Project__c where Id=:iterator.projId];
               instance1.inList = new List<InnerWrapper>();
               instance1.inlist.add(iterator);
                
                Name = iterator.projId;
            }
            else
            {
                instance1.inlist.add(iterator);
            }
            
            
        }
        projNInList.add(instance1);
        return projNInList;
    }
    
    
    
    
    public PageReference next()
    {
    if(inputDateString!='')
    {
        showPanel=true;
        inputDate = date.parse(inputDateString);
        datesOfWeek = new List<String>();
        datesOfweek.add(inputDate.toStartOfWeek().format());
        datesOfweek.add(inputDate.toStartOfWeek().addDays(1).format());
        datesOfweek.add(inputDate.toStartOfWeek().addDays(2).format());
        datesOfweek.add(inputDate.toStartOfWeek().addDays(3).format());
        datesOfweek.add(inputDate.toStartOfWeek().addDays(4).format());
        datesOfweek.add(inputDate.toStartOfWeek().addDays(5).format());
        datesOfweek.add(inputDate.toStartOfWeek().addDays(6).format());
        StandardTimeEntryLink = true;
    }
    else
    {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Please Enter a Date');
        ApexPages.addMessage(myMsg);
    }
    return null;
    }
}