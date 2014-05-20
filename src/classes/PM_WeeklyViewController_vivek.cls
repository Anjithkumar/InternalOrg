//Map<ProjectName, Map<relatedTaskName,Map<date,TimeEntry>>>

public class PM_WeeklyViewController_vivek {

// Vivek Code
public String testing {get;set;}
// Vivek Code End
    static Date selectedDate;

    public PageReference next() {
    testing  = 'Vivek';
    
    //system.assertEquals('s','sd');
        selectedDate = newEntry.Date__c;
        //system.assertEquals(selectedDate,null);
         populateTables();
        return null;
    }

    static Time_Entry__c newEntry ;
    public Time_Entry__c getInputDate(){
    if(newEntry == null){
        newEntry = new Time_Entry__c();
    }
        return newEntry ;
    }

    public PageReference reloadPage() {
        populateTables();
        return null;
    }


    public String effortPutIn {get;set;} 
    public String selectedUser {get;set;}
    public String dateOfTask {get;set;}
  
    public String selectedTimeEntryId{get;set;}
    public String selectedProject {get;set;}
    public String selectedTask {get;set;}
    public String selectedProjectName {get;set;}
    public String selectedTaskName {get;set;}

    List<String> projectIds = new List<String>();
    Map<String, Map<String,Map<String,Time_Entry__c>>> pageDetails= new Map<String, Map<String,Map<String,Time_Entry__c>>>();
    Map<String,String> projectId_projectName_Map = new Map<String,String>();
    Map<String,String> taskId_TaskName_Map = new Map<String,String>();
    
    public Map<String, Map<String,Map<String,Time_Entry__c>>> getProjectDetails(){
        //system.assertEquals(pageDetails,null);
        //populateTables();
        return pageDetails;
    }
    
    public PM_WeeklyViewController_vivek(){
        List<Project__c> setOfProjects = [select Id,Name,(select Id,Name from Project_Tasks__r) from Project__c where Id IN (select Project__c from Allocation__c where Project__r.Status__c = 'In-Progress' and Assigned_User__c = :UserInfo.getUserId())];
        for(Project__c proj: setOfProjects){
            projectIds.add(proj.Id);
            projectId_projectName_Map.put(proj.Id,proj.Name);
        }
        //populateTables();
        
    }
    
    public void populateTables(){
    
    Map<String,Map<String,Time_Entry__c>> tempprojTask_TimeEntryMap = new Map<String,Map<String,Time_Entry__c>>();
    if (selectedDate!= null){
        //Date selectedDate = newEntry.Date__c;
        String currentProj = '';
        Date startOfWeekDay = selectedDate.toStartOfWeek();
        Date endOfWeekDay = selectedDate.toStartOfWeek().addDays(6);
        
        for(Project_Task__c projTask : [select Project__c,Project__r.Name, Name,Id from Project_Task__c where Project__c IN :projectIds order by Project__c]){
            taskId_TaskName_Map.put(projTask.Id,projTask.Name);
            if(currentProj == ''){
                currentProj = projTask.Project__r.Name;
            }
            else if( currentProj == projTask.Project__r.Name){
            
            }
            else{
                pageDetails.put(currentProj, tempprojTask_TimeEntryMap);
                tempprojTask_TimeEntryMap = new Map<String,Map<String,Time_Entry__c>>();
                currentProj = projTask.Project__r.Name;
            }
            tempprojTask_TimeEntryMap.put(
                projTask.Name , new Map<String, Time_Entry__c> {
                            '0' => new Time_Entry__c(Project__c = projTask.Project__c, Related_task__c = projTask.Id,Date__c = selectedDate.toStartOfWeek(),Effort_put_in_by_User__c = UserInfo.getUserId(),Effort__c = null),
                            '1' => new Time_Entry__c(Project__c = projTask.Project__c, Related_task__c = projTask.Id,Date__c = selectedDate.toStartOfWeek().addDays(1),Effort_put_in_by_User__c = UserInfo.getUserId(),Effort__c = null),
                            '2' => new Time_Entry__c(Project__c = projTask.Project__c, Related_task__c = projTask.Id,Date__c = selectedDate.toStartOfWeek().addDays(2),Effort_put_in_by_User__c = UserInfo.getUserId(),Effort__c = null),
                            '3' => new Time_Entry__c(Project__c = projTask.Project__c, Related_task__c = projTask.Id,Date__c = selectedDate.toStartOfWeek().addDays(3),Effort_put_in_by_User__c = UserInfo.getUserId(),Effort__c = null),
                            '4' => new Time_Entry__c(Project__c = projTask.Project__c, Related_task__c = projTask.Id,Date__c = selectedDate.toStartOfWeek().addDays(4),Effort_put_in_by_User__c = UserInfo.getUserId(),Effort__c = null),
                            '5' => new Time_Entry__c(Project__c = projTask.Project__c, Related_task__c = projTask.Id,Date__c = selectedDate.toStartOfWeek().addDays(5),Effort_put_in_by_User__c = UserInfo.getUserId(),Effort__c = null),
                            '6' => new Time_Entry__c(Project__c = projTask.Project__c, Related_task__c = projTask.Id,Date__c = selectedDate.toStartOfWeek().addDays(6),Effort_put_in_by_User__c = UserInfo.getUserId(),Effort__c = null)
                }
            );
        }
        
        pageDetails.put(currentProj, tempprojTask_TimeEntryMap);
        for(Time_Entry__c timeEntry : [select Id,Name,Effort__c,Date__c,Related_Task__c,Related_Task__r.Name,Project__c,Project__r.Name,Effort_put_in_by_User__c  from Time_Entry__c where DAY_ONLY(CreatedDate) >= :startOfWeekDay  and DAY_ONLY(CreatedDate )<= :endOfWeekDay and Effort_Put_in_by_User__c = :UserInfo.getUserId() and Project__c In :projectIds order by Project__c, Related_Task__c,Date__c]){           
            pageDetails.get(timeEntry.Project__r.Name).get(timeEntry.Related_Task__r.Name).put(String.valueOf(timeEntry.Date__c.toStartOfWeek().daysBetween(timeEntry.Date__c)),timeEntry);
        } 
    }
    //system.assertEquals('s','sd');
    }
    
    
     public PageReference updateDetails() {
        selectedProjectName =  projectId_projectName_Map.get(selectedProject);
        selectedTaskName =  taskId_TaskName_Map.get(selectedTask);
        return null;
    }
    
        public PageReference upsertTimeEntry() {
            Time_Entry__c newTimeEntry;
        if(selectedTimeEntryId == '' || selectedTimeEntryId == null){
        newTimeEntry = new Time_Entry__c();
        newTimeEntry.Project__c = selectedProject;
        newTimeEntry.Related_Task__c = selectedTask;
        newTimeEntry.Effort__c = Decimal.valueOf(effortPutIn);
        newTimeEntry.Date__c = date.parse(dateOfTask);
        newTimeEntry.Effort_Put_In_By_User__c = UserInfo.getUserId();
        database.insert(newTimeEntry);
        }
        else{
            newTimeEntry = [select Project__c,Related_Task__c ,Effort__c ,Date__c,Effort_Put_In_By_User__c from Time_Entry__c where Id = :selectedTimeEntryId];
            newTimeEntry.Effort__c = Decimal.valueOf(effortPutIn);
            newTimeEntry.Date__c = date.parse(dateOfTask);
            newTimeEntry.Effort_Put_In_By_User__c = UserInfo.getUserId();
            database.update(newTimeEntry);
        }
        return null;
    }
    
}