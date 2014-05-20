trigger Project_CreateTask on Project__c(after insert) 

{
    for(Project__c newproj : Trigger.New)
    {
        for(Task_Type__c c1:[select Project_Category__c,Default__c,Task_Name__c from Task_Type__c where Project_Category__c= :newproj.Project_Category__c])
        {
            Project_Task__c newProjectRec = new Project_Task__c();
            newProjectRec.Name = c1.Task_Name__c;
            newProjectRec.Project__c = newproj.Id;
            insert newProjectRec;
        }
    /*   for(Milestone_Type__c c1:[select Project_Category__c,Default__c,Milestone_Name__c from Milestone_Type__c where Project_Category__c= :newproj.Project_Category__c])
        {
            Project_Milestone__c newMileStoneRec = new Project_Milestone__c();
            
            newMileStoneRec.Name = c1.Milestone_Name__c ;
            newMileStoneRec.Project__c = newproj.id;
            insert newMileStoneRec ;
        }*/
    }
}