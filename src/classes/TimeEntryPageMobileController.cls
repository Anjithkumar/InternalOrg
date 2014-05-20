global with sharing class TimeEntryPageMobileController {
    //Attributes
    public String userAgent {get;set;}
    public static final Integer DAY_DIFF = 5; 
    //Constructor
    public TimeEntryPageMobileController () {
        userAgent = ApexPages.currentPage().getHeaders().get('USER-AGENT');
        
        if(userAgent.contains('iPhone') || userAgent.contains('iPad') || userAgent.contains('iPod')){
        
            userAgent = 'iPhone';
        
        }else{
        
            userAgent = 'Others';
        }
        /*
        if(userAgent.contains('webOS') || userAgent.contains('iPhone') || userAgent.contains('iPad') || userAgent.contains('iPod') || userAgent.contains('BlackBerry') || userAgent.contains('Windows Phone') || userAgent.contains('Android')) {
            userAgent ='Phone';
        }
        else{
            userAgent ='Desktop';
        }
       */
    }
    
    //Methods
    /*
    Code for the page TimeEntryPageMobile
    */
    //Get projects 
    @RemoteAction
    global static List<Project__c> queryProjectsName() {
        return [select Id,Name from Project__c where Status__c = 'In-Progress'  AND Id IN(select Project__c from Allocation__c where Assigned_User__c=:UserInfo.getUserId())  order by Name];
    }

    //Get project tasks
    @RemoteAction
    global static List<Project_Task__c> queryProjectTasks(String ids) {
        return [Select Id,Name from Project_Task__c where Project__c=:ids];
    }
    
    //Bar Data Class
    
    global class BarChartClass{
    
        public String dateValue {get;set;}
        public Decimal effort {get;set;}
        
        public BarChartClass(String d,Decimal d1){
        
            this.dateValue = d;
            this.effort = d1;
            
        }
    
    
    }
    
    @RemoteAction
    global static List<BarChartClass> fetchLastFiveDayTimeEntry() {
        
        List<BarChartClass> barDataList = new List<BarChartClass>();
        
        Date fDate = Date.today().addDays(-1*DAY_DIFF);
        Date tDate = Date.today();
        
 
        
        Map<Integer,Decimal> effortPerDate = new Map<Integer,Decimal>();
        
        
        
    
        for(Time_Entry__c tEntry : [SELECT id,Effort__c,Date__c FROM Time_Entry__c WHERE Date__c >=:fDate AND Date__c <= :tDate AND Effort_Put_in_by_User__c =: UserInfo.getUserId() Order by Date__c]){
            
            
            if(effortPerDate.get(tEntry.Date__c.day()) == null){
            
                effortPerDate.put(tEntry.Date__c.day(),tEntry.Effort__c);
            
            }else{
            
                Decimal temp = effortPerDate.get(tEntry.Date__c.day());
                temp = temp + tEntry.Effort__c;
                effortPerDate.put(tEntry.Date__c.day(),temp);
            
            }

        
        }
        
        List<Integer> keyValues = new List<Integer>();
        Set<Integer> temp1 = new Set<Integer>();
        
        temp1 =  effortPerDate.keySet();
        keyValues.addAll(temp1);
        keyValues.sort();
        
        for(Integer keyV : keyValues){
        
                    
            BarChartClass b = new BarChartClass(String.valueOf(keyV),effortPerDate.get(keyV));
            barDataList.add(b);
        
        }
        
        return barDataList;
    }

    //Save time entry
    
    @RemoteAction
    
    global static String saveTimeEntryRecord(String projId,String taskId,String dt,String actDes,String eff,Boolean b) {
     
     system.debug(dt);
     String[] str = dt.split('-');
     Date d = date.newinstance(Integer.valueOf(str[0]), Integer.valueOf(str[1]), Integer.valueOf(str[2]));
     system.debug(projId + '' + taskId + '' + d + '' + actDes + '' + Decimal.valueof(eff) + '' + b);
     
     
     Time_Entry__c tEntry = new Time_Entry__c(Project__c = projId ,Related_Task__c =taskId ,Date__c = d,Activity_Description__c =actDes ,Effort__c = Decimal.valueof(eff),Client_Recoverable__c = b, Effort_Put_in_by_User__c = UserInfo.getUserId());
       
     try{
        system.debug(tEntry);
        insert tEntry;
     
     return 'Successfully Created';
     }catch(Exception e){
     
     return e.getMessage();
     }
     
    
    }
}