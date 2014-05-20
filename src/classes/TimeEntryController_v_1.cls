public class TimeEntryController_v_1 
{
    //public String currentUserId{get;set;}
    
    public String projectIdValue{get;set;}
    public String taskIdValue {get;set;}
    public String effortValue{get;set;}
    public String dateValue{get;set;}
    public String activityDescription{get;set;}
    public Boolean clientrecoverable{get;set;}
    public String timeEntryTab{get;set;}
    public String WeeklyViewTab{get;set;}
    public String BasicWizardTab{get;set;}
    public String Home{get;set;}
    public TimeEntryController_v_1()
    {
        timeEntryTab='active';
        WeeklyViewTab='#';
        BasicWizardTab='#';
        Home='#';
        //currentUserId = UserInfo.getUserId();
        //listOfProject = [select Id,Name from Project__c where Status__c = 'In-Progress'  AND Id IN(select Project__c from Allocation__c where Assigned_User__c=:UserInfo.getUserId())  order by CreatedDate];
    }
    public class taskProjectWrapper
    {
        public Integer counter{get;set;}
        public String projectId{get;set;}
        public List<Project_Task__c> projTaskList{get;set;}
    }
    public List<taskProjectWrapper> getUserProj()
    {
        try
        {
            List<Project__c> listOfProject = [select Id,Name from Project__c where Status__c = 'In-Progress'  AND Id IN(select Project__c from Allocation__c where Assigned_User__c=:UserInfo.getUserId())  order by Name];
            if(listOfProject!=null)
            {
                String projId = '';
                List<Project_Task__c> listProjTask;
                List<taskProjectWrapper> listtaskProj = new List<taskProjectWrapper>();
                //listtaskProject.
                //taskProjectWrapper instance;
                if(listOfProject!=null)
                {
                    for(Project_Task__c projTask:[select Id,Name,Project__c,Project__r.Name,Project__r.Id from Project_Task__c where Project__c IN:listOfProject order by Project__r.Name])
                    {
                        if(projId==''||projId!=projTask.Project__r.Name)
                        {
                            if(projId!='')
                            {
                                //System.debug('This is it '+projId);
                                taskProjectWrapper instance = new taskProjectWrapper();
                                instance.projTaskList = new List<Project_task__c>();
                                instance.projectId = String.valueOf(projId);
                                instance.projTaskList.addAll(listProjTask);
                                listtaskProj.add(instance);
                            }
                            projId = projTask.Project__r.Name;
                            listProjTask = new List<Project_Task__c>();
                            listProjTask.add(projTask);
                        }
                        else
                        {
                            listProjTask.add(projTask);
                        }
                    }
                    taskProjectWrapper instance = new taskProjectWrapper();
                    instance.projTaskList = new List<Project_task__c>();
                    instance.projectId = String.valueOf(projId);
                    instance.projTaskList.addAll(listProjTask);
                    listtaskProj.add(instance);
                    
                }
                for(integer i=0;i<listtaskProj.size();i++)
                {
                    listtaskProj[i].counter= i+1;
                }
                //System.debug(listtaskProj);
                return listtaskProj;
            }
            else
            {
                return null;
            }
        }
        catch(Exception e){return null;}
    } 
    public PageReference saveTimeEntryRecord()
    {
    
    System.debug('Project-> '+projectIdValue+' RelatedTask-> '+taskIdValue+' Effort-> '+effortValue+' ClientRecoverable-> '+clientrecoverable+' ActivityDescription-> '+activityDescription+' Date-> '+dateValue);
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
    
    //projectIdValue
    //taskIdValue
    //effortValue
    //dateValue    
    //activityDescription
    //clientrecoverable
    return null;
    }
    
    
    
}