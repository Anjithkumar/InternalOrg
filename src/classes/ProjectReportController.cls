public without sharing class ProjectReportController {

    public List<SelectOption> projectNameOption {get; set;}
    public List<Project__c> projectNameList {get; set;}
    public String projectProbability {get; set;}
    public String projectId {get; set;}
    
    public ProjectReportController(){ 
        string queryString = 'Select Name From Project__c Where Status__c = \'In-Progress\'';
        List<Project__c> projectName = Database.query(queryString);
        projectNameOption = new List<SelectOption>();
        projectNameOption.add(new SelectOption('NULL', ' -- Select -- '));
        for(Project__c P: projectName){
            projectNameOption.add(new SelectOption(P.Id, P.Name)); 
        }
    }
    
    public List<SelectOption> getDealProbability(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('NULL', ' -- Select -- '));
        list<Schema.PicklistEntry> values = Deal__c.Probability__c.getDescribe().getPickListValues();
        for (Schema.PicklistEntry a : values)
        { 
            options.add(new SelectOption(a.getValue(), a.getLabel())); 
        }
        return options;
    }   
    
    public List<ProjectManagementWrapper> ListOfProjects {get;set;}
    
    public pageReference displayProjectDetail(){
        string queryString = 'Select Name, Sales_Order__r.Deal__c, Actual_Start_Date__c, Actual_End_Date__c From Project__c Where Status__c = \'In-Progress\'';
        if(projectProbability != 'NULL'){
            queryString += ' AND Sales_Order__r.Deal__r.Probability__c = : projectProbability';
        }
        if(projectId != 'NULL'){
            queryString += ' AND Id = : projectId';
        }
        projectNameList = Database.query(queryString);
        
        List<Resource_Forecast__c> listOfResourceForecast = [select Deal__c, Role__c, Start_Date__c, End_Date__c, Quantity__c From Resource_Forecast__c];
        
        Map<Id, List<Resource_Forecast__c>> mapOfResourceForecast = new Map<Id, List<Resource_Forecast__c>>();
        ListOfProjects = new List<ProjectManagementWrapper>();
        for(Resource_Forecast__c RF: listOfResourceForecast){
            if(mapOfResourceForecast.get(RF.Deal__c) != NULL){
                mapOfResourceForecast.get(RF.Deal__c).add(RF);
            }else{
                mapOfResourceForecast.put(RF.Deal__c, new List<Resource_Forecast__c>{RF});
            }
        }
        Map<Id, List<Allocation__c>> mapOfAllocation = new Map<Id, List<Allocation__c>>();
        
        List<Allocation__c> listOfAllocation = [Select Name, Project__c, Role__c From Allocation__c];
        for(Allocation__c allot: listOfAllocation){
            if(mapOfAllocation.get(allot.Project__c) != NULL){
                mapOfAllocation.get(allot.Project__c).add(allot);
            }else{
                mapOfAllocation.put(allot.Project__c, new List<Allocation__c>{allot});
            }
        }
        
        for(Project__c p: projectNameList) {
            String projectName;
            Decimal projectManager;
            Decimal teamLead;
            Decimal seniorDeveloper;
            Decimal developer;
            Decimal allotedProjectManager;
            Decimal allotedTeamLead = 0;
            Decimal allotedSeniorDeveloper;
            Decimal allotedDeveloper;
            Date startDate;
            Date endDate;
            
           
            for(Allocation__c allot: mapOfAllocation.get(p.Id)){
                if(allot.Role__c != NULL){
                    if(allot.Role__c.toUpperCase().contains('MANAGER')){
                        allotedProjectManager += 1;
                    }
                    if(allot.Role__c.toUpperCase().contains('LEAD')){
                        allotedTeamLead += 1;
                    }
                    if(allot.Role__c.toUpperCase().contains('SENIOR')){
                        allotedSeniorDeveloper += 1;
                    }
                    if(allot.Role__c.toUpperCase().contains('DEVELOPER')){
                        allotedDeveloper += 1;
                    }
                }
            }
            
            for(Resource_Forecast__c RF1: mapOfResourceForecast.get(p.Sales_Order__r.Deal__c)){
                                
                if(RF1.Role__c.toUpperCase().contains('MANAGER')){
                    projectManager = RF1.Quantity__c;
                }
                if(RF1.Role__c.toUpperCase().contains('LEAD')){
                teamLead = RF1.Quantity__c;
                }
                if(RF1.Role__c.toUpperCase().contains('SENIOR')){
                seniorDeveloper = RF1.Quantity__c;
                }
                if(RF1.Role__c.toUpperCase().contains('DEVELOPER')){
                developer = RF1.Quantity__c;
                }                
            }
            projectName = p.Name;
            startDate = p.Actual_Start_Date__c;
            endDate = p.Actual_End_Date__c;
                
            ListOfProjects.add(new ProjectManagementWrapper(p.Id, p.Name, projectManager, teamLead, seniorDeveloper, developer, allotedProjectManager, allotedTeamLead, allotedSeniorDeveloper, allotedDeveloper, startDate, endDate));
        }
        
        return null;
    }
    
    public class ProjectManagementWrapper{
        public String projectId{get;set;}
        public String projectName{get;set;}
        public Decimal projectManager{get;set;}
        public Decimal teamLead{get;set;}
        public Decimal seniorDeveloper{get;set;}
        public Decimal developer{get;set;}
        public Decimal allotedProjectManager{get;set;}
        public Decimal allotedTeamLead{get;set;}
        public Decimal allotedSeniorDeveloper{get;set;}
        public Decimal allotedDeveloper{get;set;}
        public Date startDate{get;set;}
        public Date endDate{get;set;}
       
        public ProjectManagementWrapper(Id pId, String pName, Decimal pManager, Decimal tLead, Decimal sDeveloper, Decimal dev, Decimal aPManager, Decimal aTLead, Decimal aSDeveloper, Decimal aDev , Date sDate, Date eDate)
        {
            projectId = pId;
            projectName = pName;
            projectManager = pManager;
            teamLead = tLead;
            seniorDeveloper = sDeveloper;
            developer = dev; 
            allotedProjectManager = aPManager;
            allotedTeamLead = aTLead;
            allotedSeniorDeveloper = aSDeveloper;
            allotedDeveloper = aDev;            
            startDate = sDate; 
            endDate = eDate;

        }
    }
    
}