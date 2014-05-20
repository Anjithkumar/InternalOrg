public class AvailableResourcesController {
    Id projectId;
    Project__c p;
    
    public List<Allocation__c> availableResourcesList {get;set;} 
    public List<AvailableUserWrapper> availableUser {get;set;}
    
    public AvailableResourcesController(){
        projectId = ApexPages.currentPage().getParameters().get('id');
        p = [Select Id, Actual_Start_Date__c, Actual_End_Date__c From Project__c Where Id =: projectId];
    }
    
    public void availableResources(){
        availableResourcesList = new List<Allocation__c>();
        List<Allocation__c> unAvailableResourcesList = [Select Id, Assigned_User__c From Allocation__c Where Start_Date__c <=: p.Actual_Start_Date__c AND End_Date__c >=: p.Actual_End_Date__c];
        Set<Id> unAvailableUserIds = new Set<Id>();
        for(Allocation__c allot: unAvailableResourcesList){
            unAvailableUserIds.add(allot.Assigned_User__c);
        }        

        availableResourcesList = [Select Id, Role__c, Assigned_User__r.UserRole.Name, Assigned_User__r.Name, Start_Date__c, End_Date__c From Allocation__c Where Assigned_User__c Not IN : unAvailableUserIds];
        for(Allocation__c allot: availableResourcesList){
            if(allot.Start_Date__c < p.Actual_Start_Date__c || allot.End_Date__c > p.Actual_End_Date__c){
                availableUser.add(new AvailableUserWrapper(allot.Assigned_User__r.Name, allot.Assigned_User__r.UserRole.Name, allot.Start_Date__c, allot.End_Date__c));
            }            
        }        
    }
    
    public class AvailableUserWrapper{
        public String userName{get;set;}
        public String userRole{get;set;}
        public Date startDate{get;set;}
        public Date endDate{get;set;}
       
        public AvailableUserWrapper(String uName, String uRole, Date sDate, Date eDate)
        {
            userName = uName;
            userRole = uRole;            
            startDate = sDate; 
            endDate = eDate;
        }
    }
    
}