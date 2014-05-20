global with sharing class TimeEntryDetail{
    
    
    //-- ATTRIBUTES
    public String StartDate {get; set;}
    public String EndDate {get; set;}
    public Boolean showHidePieChart{get;set;}
    public List<PieDataClass> data;
    public Boolean showHideDetailedView{get;set;}
    public List<SelectOption> selectList = new List<SelectOption>() ;   
    public Integer selectListSize ; 
    public String SelectedOption{get;set;}
    public List<BarDataClass> chartData;
    public Date stDate ;
    public Date edDate ;
    public Decimal TotalHours = 0;
    public Decimal clientBillable = 0;
    public Decimal userInternal = 0;
    public Decimal notFilled = 0;
    public List<User> userId = new List<User>();
    public Boolean showHideIndividualView{get;set;}
    public List<DataTableClass> tableData;
    public List<Time_Entry__c> timeEntryDetailList;
    
    
    
    //-- WRAPPER CLASS  
    global class PieDataClass{
        
        public String name {get;set;}
        public Decimal hoursDetail {get;set;}
        
        public PieDataClass(String nm,Decimal hD){
            
            this.name = nm;
            this.hoursDetail = hD;
        }
        
    }
    
    global class BarDataClass{
        
        public String name {get;set;}
        public Decimal clientHoursDetail {get;set;}
        public Decimal internalHoursDetail{get;set;}
        public Decimal notFilledHoursDetail{get;set;}
        
        public BarDataClass(String nm,Decimal hD,Decimal iD,Decimal nFD){
            
            this.name = nm;
            this.clientHoursDetail = hD;
            this.internalHoursDetail = iD;
            this.notFilledHoursDetail = nFD;            
        }
        
    } 

public class DataTableClass{
    
    public String employeeName{get;set;}
    public String project{get;set;}
    public Decimal effort{get;set;}
    public String workDescription{get;set;}
    
    public DataTableClass(String empName,String project,Decimal effort,String workDescription){
        
        this.employeeName = empName;
        this.project = project;
        this.effort = effort;
        }
  }
  
  
    //-- CONSTRUCTOR
    
    public TimeEntryDetail(){
        showHidePieChart = false;
        showHideDetailedView = false;
        showHideIndividualView = false;
     
        userId = new List<User>();
        // Fetch Id's of all the developers
        for(User user : [SELECT Id,Name,Unit__c FROM User WHERE IsActive=true AND Unit__c='Service-Delivery']){
            userId.add(user);
        }
        Map<Id,User> userTimeEntry = new Map<Id,User>();
        
    }
    
    
    //-- METHODS
    
    public List<SelectOption> getSelectList(){
        
        return selectList;
    }
    
    
    public List<PieDataClass> getPieData(){
        
        return data;
    }
    
    public List<BarDataClass> getBarDataClass(){
        
        return chartData;
    }
    
    public List<DataTableClass> getDataTableClass(){
        
        return tableData ;
    }
    //--Total Number of days excluding weekends  
    public static Integer daysBetweenExcludingWeekends(Datetime startDate, Datetime endDate) {
        Integer days = 0;
        while (startDate <= endDate) {
            if (startDate.format('EEE') != 'Sat' && startDate.format('EEE') != 'Sun') {
                days = days + 1;
            }
            startDate = startDate.addDays(1);
        }
        return days;
    }
    /*
    //--Send Mail To User on the barChart View
    @RemoteAction
    global static void sendMailToAllUsers(){
        List<User> userId = new List<User>();
        for(User user : [SELECT Id,Name,Unit__c FROM User WHERE IsActive=true AND Unit__c='Service-Delivery']){
             userId.add(user);
             }
          
           
        
    }
    */
    
    //--Pie Chart of a single User
     @RemoteAction
     global static List<PieDataClass> getIndividualPieChart(Id userId,String StartDate,String EndDate){
        List<PieDataClass> pieData = new List<PieDataClass>();
            Date stDate = Date.parse(StartDate);
            Date edDate = Date.parse(EndDate);
            List<Time_Entry__c> timeEntryDetailList = [SELECT Date__c, Effort__c,Effort_Put_in_by_User__r.Name, Client_Recoverable__c,Project__r.Name,Project__r.Project_Type__c FROM Time_Entry__c WHERE Date__c >=: stDate AND Date__c <=: edDate AND Effort_Put_in_by_User__c=: userId order by Project__c ];
           System.debug('///////////////'+timeEntryDetailList);
            Decimal totalHoursIn = 8*daysBetweenExcludingWeekends(stDate, edDate);
            String ProjectsName = '';
            String ProjectType = '';
            Decimal clientBillable = 0 ;
            Decimal userInternal = 0 ;
            Integer count = 0;
            for(Time_Entry__c timeEntry : timeEntryDetailList){
                count = count + 1;
                if(ProjectsName==''){
                    ProjectsName = timeEntry.Project__r.Name;
                    ProjectType =  timeEntry.Project__r.Project_Type__c;
                    if(timeEntry.Client_Recoverable__c==true){
                        clientBillable= timeEntry.Effort__c ;
                    }else{
                        userInternal = timeEntry.Effort__c ;
                    }
                }else if(ProjectsName==timeEntry.Project__r.Name){
                    if(timeEntry.Client_Recoverable__c==true){
                        clientBillable += timeEntry.Effort__c ;
                    }else{
                        userInternal += timeEntry.Effort__c ;
                    }
                    
                }else if(ProjectsName!=timeEntry.Project__r.Name){
                    if(ProjectType=='Internal'){
                       pieData.add(new PieDataClass(ProjectsName,userInternal));
                    }else{
                       pieData.add(new PieDataClass(ProjectsName,clientBillable));
                    }
                    
                    System.debug('.......................................'+pieData);                    
                    if(timeEntry.Client_Recoverable__c==true){
                        clientBillable += timeEntry.Effort__c ;
                    }else{
                        userInternal += timeEntry.Effort__c ;
                    }
                }
                ProjectsName = timeEntry.Project__r.Name;
                ProjectType =  timeEntry.Project__r.Project_Type__c;
                
                
            } 
            
            
            if(timeEntryDetailList.size()==count){
                 if(ProjectType=='Internal'){
                        pieData.add(new PieDataClass(ProjectsName,userInternal));
                    }else{
                       pieData.add(new PieDataClass(ProjectsName,clientBillable));
                    }
                if(totalHoursIn>(userInternal+clientBillable)){                 
               pieData.add(new PieDataClass('Not Filled',(totalHoursIn-(clientBillable+userInternal))));                    
                  }    
                else{
                     pieData.add(new PieDataClass('Not Filled',0.0));
                    
                } 
                }
                return pieData ;
        }
        
    //--Bar Chart all users time entry
    @RemoteAction
    global static List<BarDataClass> getGrahicalDateForBarChart(String StartDate,String EndDate){
              List<BarDataClass> chartData = new List<BarDataClass>();
              List<User> userId = new List<User>();
              Date stDate = Date.parse(StartDate);
              Date edDate = Date.parse(EndDate);
              List<User> timeEntryUser = new List<User>();
             for(User user : [SELECT Id,Name,Unit__c FROM User WHERE IsActive=true AND Unit__c='Service-Delivery']){
             userId.add(user);
             }
            List<Time_Entry__c>   timeEntryDetailList = new List<Time_Entry__c>();
            timeEntryDetailList = [SELECT Date__c, Effort__c,Effort_Put_in_by_User__c, Client_Recoverable__c,Project__c,CreatedById,CreatedBy.Name FROM Time_Entry__c WHERE Date__c >=: stDate AND Date__c <=: edDate AND CreatedById IN :userId Order by CreatedById ]; 
            Decimal totalHoursIn = 8 * daysBetweenExcludingWeekends(stDate, edDate);
            System.debug('>>>>>>>>>>>>>>>>>>>>>>'+timeEntryDetailList); 
            String oldUserId = null;
            String userName = null;
            Decimal clientRecoverable = 0.0;
            Decimal internal = 0.0;
            Decimal notFilled = 0.0;
            Integer count = 0 ;
            system.debug(timeEntryDetailList + 'TDDDDDD');
            system.debug(timeEntryDetailList.size() + 'TDDDDDD');
            for(Time_Entry__c timeEntry : timeEntryDetailList){
                //BarDataClass userDetails = new BarDataClass(timeEntry.CreatedBy.Name,);            
                //Check for the first record
                count = count+1;            
                if(oldUserId == null){
                    oldUserId = timeEntry.CreatedById;
                    userName = timeEntry.CreatedBy.Name;
                    if(timeEntry.Client_Recoverable__c)
                        clientRecoverable = clientRecoverable+timeEntry.Effort__c;
                    else
                        internal = internal + timeEntry.Effort__c;                    
                }else if(oldUserId == timeEntry.CreatedById){
                    if(timeEntry.Client_Recoverable__c)
                        clientRecoverable = clientRecoverable+timeEntry.Effort__c;
                    else
                        internal = internal + timeEntry.Effort__c;
                }else if(oldUserId != timeEntry.CreatedById){
                    if(totalHoursIn>(clientRecoverable+internal)){
                        notFilled = totalHoursIn-(clientRecoverable+internal) ;
                    }else{
                        notFilled = 0.0 ;
                    }
                    BarDataClass userDetails = new BarDataClass(userName,clientRecoverable,internal,notFilled);
                   
                    System.debug(count +'>>>>>>>>>>>>>>>>>>>>>>>>>>');
                    system.debug(userDetails + '>> UD');
                    chartData.add(userDetails);
                    userName = timeEntry.CreatedBy.Name;               
                    if(timeEntry.Client_Recoverable__c)
                        clientRecoverable = timeEntry.Effort__c;
                    else
                        internal = timeEntry.Effort__c; 
                    
                    system.debug(userName +'' +clientRecoverable+''+internal+''+(totalHoursIn-(clientRecoverable+internal)));   
                }
                
                oldUserId = timeEntry.CreatedById;
                
                
            }    
            if(timeEntryDetailList.size()==count){
                if(totalHoursIn>(clientRecoverable+internal)){
                        notFilled = totalHoursIn-(clientRecoverable+internal) ;
                    }else{
                        notFilled = 0.0 ;
                    }
                chartData.add(new BarDataClass(userName,clientRecoverable,internal,notFilled));
            } 
            
            system.debug(chartData + 'DATATATATA');
        return chartData;
    }
    
    //--Time Entry Over all view 
    @RemoteAction
    global static List<PieDataClass> getPiaDataForJavaScript(String StartDate,String EndDate){
        List<PieDataClass> dataJS = new List<PieDataClass>();
        List<User> userId = new List<User>();
        system.debug(StartDate + '>>>>>>>>>>>>');
        system.debug(EndDate + '>>>>>>>>>>>>');
        for(User user : [SELECT Id,Name,Unit__c FROM User WHERE IsActive=true AND Unit__c='Service-Delivery']){
            userId.add(user);
        }
        System.debug(userId);
        Date stDate = Date.parse(StartDate);
        Date edDate = Date.parse(EndDate);
        
        Integer days = daysBetweenExcludingWeekends(stDate, edDate);
        
        Decimal Total_Num_Of_Hours = days * 8 * userId.size();
        Decimal ClientRecoverable = 0;
        Decimal Internal = 0;
        Decimal NotFilled = 0 ;
        //timeEntryDetailList = new List<Time_Entry__c>();
        //timeEntryDetailList = [SELECT Date__c, Effort__c,Effort_Put_in_by_User__c,CreatedById,CreatedBy.Name, Client_Recoverable__c,Project__c,Activity_Description__c FROM Time_Entry__c WHERE Date__c >=: stDate AND Date__c <=: edDate AND CreatedById IN :userId Order by CreatedById]; 
        for(Time_Entry__c timeEntry : [SELECT Date__c, Effort__c,Effort_Put_in_by_User__c,CreatedById,CreatedBy.Name, Client_Recoverable__c,Project__c,Activity_Description__c FROM Time_Entry__c WHERE Date__c >=: stDate AND Date__c <=: edDate AND CreatedById IN :userId Order by CreatedById]){
            if(timeEntry.Client_Recoverable__c==true){
                ClientRecoverable += timeEntry.Effort__c ;
            }else{
                Internal += timeEntry.Effort__c ;
            }
        }
        
        NotFilled = Total_Num_Of_Hours  - (ClientRecoverable +Internal) ; 
        System.debug('///////////////'+userId.size());
        System.debug('///////////////'+days);
        System.debug('///////////////'+Total_Num_Of_Hours);
        System.debug('///////////////'+ClientRecoverable);
        System.debug('///////////////'+Internal);
        System.debug('///////////////'+NotFilled);  
        
        //Decimal ClientBillableHours = ((ClientRecoverable * 100)/(Total_Num_Of_Hours));
        //Decimal InternalHours = ((Internal * 100)/(Total_Num_Of_Hours));
        //Decimal NotFilledHours = ((NotFilled * 100)/(Total_Num_Of_Hours));
        
        dataJS.add(new PieDataClass('Not Filled',NotFilled));
        dataJS.add(new PieDataClass('Internal',Internal));
        dataJS.add(new PieDataClass('Client Recoverable',ClientRecoverable));
         System.debug('///////////////'+dataJS);  

        return dataJS;
    }
    
    //-- Search 
    public PageReference search(){
        
        showHidePieChart = true;
        
        data = new List<PieDataClass>();
        
        system.debug(StartDate + '>>>>>>>>>>>>');
        system.debug(EndDate + '>>>>>>>>>>>>');
        
        stDate = Date.parse(StartDate);
        edDate = Date.parse(EndDate);
        
        Integer days = daysBetweenExcludingWeekends(stDate, edDate);
        
        Decimal Total_Num_Of_Hours = days * 8 * userId.size();
        Decimal ClientRecoverable = 0;
        Decimal Internal = 0;
        Decimal NotFilled = 0 ;
        timeEntryDetailList = new List<Time_Entry__c>();
        timeEntryDetailList = [SELECT Date__c, Effort__c,Effort_Put_in_by_User__c,CreatedById,CreatedBy.Name, Client_Recoverable__c,Project__c,Activity_Description__c FROM Time_Entry__c WHERE Date__c >=: stDate AND Date__c <=: edDate AND CreatedById IN :userId Order by CreatedById]; 
        for(Time_Entry__c timeEntry : timeEntryDetailList){
            if(timeEntry.Client_Recoverable__c==true){
                ClientRecoverable += timeEntry.Effort__c ;
            }else{
                Internal += timeEntry.Effort__c ;
            }
        }
        
        NotFilled = Total_Num_Of_Hours  - (ClientRecoverable +Internal) ; 
        System.debug('///////////////'+userId.size());
        System.debug('///////////////'+days);
        System.debug('///////////////'+Total_Num_Of_Hours);
        System.debug('///////////////'+ClientRecoverable);
        System.debug('///////////////'+Internal);
        System.debug('///////////////'+NotFilled);  
        
        Decimal ClientBillableHours = ((ClientRecoverable * 100)/(Total_Num_Of_Hours));
        Decimal InternalHours = ((Internal * 100)/(Total_Num_Of_Hours));
        Decimal NotFilledHours = ((NotFilled * 100)/(Total_Num_Of_Hours));
        
        data.add(new PieDataClass('Not Filled',NotFilledHours));
        data.add(new PieDataClass('Internal',InternalHours));
        data.add(new PieDataClass('Client Recoverable',ClientBillableHours));
        selectList.add(new SelectOption('all','--All--'));
        for (User user : userId) {
            selectList.add(new SelectOption(user.Id,user.Name));
        }
        
        return null;
    }
    
    //-- Details
    public PageReference details(){
        showHideDetailedView = true ;               
        Profile userProfile = [SELECT Id,Name FROM Profile where Name='Developer Force One App'];
        User[] users = [SELECT Id, Name FROM User Where isActive = true AND profileId=:userProfile.Id AND Id IN: userId];
        selectList.add(new SelectOption('all','--All--'));
        for (User user : users) {
            selectList.add(new SelectOption(user.Id,user.Name));
        }
        System.debug('//////////////////////////////'+selectList);
        return null ;
    }

    @RemoteAction
    global static List<User> getUserNames(){
        return [SELECT Id,Name,Unit__c FROM User WHERE IsActive=true AND Unit__c='Service-Delivery'];
    }
    
    @RemoteAction
   global static  List<BarDataClass> graphicalViewJS(){
    return null;
   }
    //graphicalView
    public PageReference graphicalView(){
        System.debug('///////////////'+SelectedOption);
        //SelectedOption = 'all';
        chartData = new List<BarDataClass>();
        
        showHideDetailedView = true;
        
        if(SelectedOption =='all'){
            timeEntryDetailList = new List<Time_Entry__c>();
            timeEntryDetailList = [SELECT Date__c, Effort__c,Effort_Put_in_by_User__c, Client_Recoverable__c,Project__c,CreatedById,CreatedBy.Name FROM Time_Entry__c WHERE Date__c >=: stDate AND Date__c <=: edDate AND CreatedById IN :userId Order by CreatedById ]; 
            Decimal totalHoursIn = 8 * userId.size() * daysBetweenExcludingWeekends(stDate, edDate);
            System.debug('>>>>>>>>>>>>>>>>>>>>>>'+timeEntryDetailList); 
            String oldUserId = null;
            String userName = null;
            Decimal cR = 0.0;
            Decimal inTernalDet = 0.0;
            Decimal nTF = 0.0;
            Integer count = 0 ;
            system.debug(timeEntryDetailList + 'TDDDDDD');
            system.debug(timeEntryDetailList.size() + 'TDDDDDD');
            for(Time_Entry__c timeEntry : timeEntryDetailList){
                //BarDataClass userDetails = new BarDataClass(timeEntry.CreatedBy.Name,);            
                //Check for the first record
                count = count+1;            
                if(oldUserId == null){
                    oldUserId = timeEntry.CreatedById;
                    userName = timeEntry.CreatedBy.Name;
                    if(timeEntry.Client_Recoverable__c)
                        cR = cR+timeEntry.Effort__c;
                    else
                        inTernalDet = inTernalDet + timeEntry.Effort__c;                    
                }else if(oldUserId == timeEntry.CreatedById){
                    if(timeEntry.Client_Recoverable__c)
                        cR = cR+timeEntry.Effort__c;
                    else
                        inTernalDet = inTernalDet + timeEntry.Effort__c;
                }else if(oldUserId != timeEntry.CreatedById){
                    BarDataClass userDetails = new BarDataClass(userName,cR,inTernalDet,(totalHoursIn-(cR+inTernalDet)));
                   
                    System.debug(count +'>>>>>>>>>>>>>>>>>>>>>>>>>>');
                    system.debug(userDetails + '>> UD');
                    chartData.add(userDetails);
                    userName = timeEntry.CreatedBy.Name;               
                    if(timeEntry.Client_Recoverable__c)
                        cR = timeEntry.Effort__c;
                    else
                        inTernalDet = timeEntry.Effort__c; 
                    
                    system.debug(userName +'' +cR+''+inTernalDet+''+(totalHoursIn-(cR+inTernalDet)));   
                }
                
                oldUserId = timeEntry.CreatedById;
                
                
            }    
            if(timeEntryDetailList.size()==count){
                chartData.add(new BarDataClass(userName,cR,inTernalDet,(totalHoursIn-(cR+inTernalDet))));
            } 
            
            system.debug(chartData + 'DATATATATA');
        }
        else{
            String userName = SelectedOption ;
            System.debug('///////////////'+SelectedOption);
            List<Time_Entry__c> timeEntryDetailList = [SELECT Date__c, Effort__c,Effort_Put_in_by_User__r.Name, Client_Recoverable__c,Project__r.Name,Project__r.Project_Type__c FROM Time_Entry__c WHERE Date__c >=: stDate AND Date__c <=: edDate AND Effort_Put_in_by_User__r.Name=:userName order by Project__c ];
           System.debug('///////////////'+timeEntryDetailList);
            Decimal totalHoursIn = 5*daysBetweenExcludingWeekends(stDate, edDate);
             data = new List<PieDataClass>();
            String ProjectsName = '';
            String ProjectType = '';
            Integer count = 0;
            for(Time_Entry__c timeEntry : timeEntryDetailList){
                count = count + 1;
                if(ProjectsName==''){
                    ProjectsName = timeEntry.Project__r.Name;
                    ProjectType =  timeEntry.Project__r.Project_Type__c;
                    if(timeEntry.Client_Recoverable__c==true){
                        clientBillable= timeEntry.Effort__c ;
                    }else{
                        userInternal = timeEntry.Effort__c ;
                    }
                }else if(ProjectsName==timeEntry.Project__r.Name){
                    if(timeEntry.Client_Recoverable__c==true){
                        clientBillable += timeEntry.Effort__c ;
                    }else{
                        userInternal += timeEntry.Effort__c ;
                    }
                }else if(ProjectsName!=timeEntry.Project__r.Name){
                    if(ProjectType=='Internal'){
                        data.add(new PieDataClass(ProjectsName,userInternal));
                    }else{
                        data.add(new PieDataClass(ProjectsName,clientBillable));
                    }
                    System.debug('.......................................'+data);                    
                    if(timeEntry.Client_Recoverable__c==true){
                        clientBillable += timeEntry.Effort__c ;
                    }else{
                        userInternal += timeEntry.Effort__c ;
                    }
                }
                ProjectsName = timeEntry.Project__r.Name;
                ProjectType =  timeEntry.Project__r.Project_Type__c;
                
                
            } 
            if(timeEntryDetailList.size()==count){
             if(ProjectType=='Internal'){
                        data.add(new PieDataClass(ProjectsName,userInternal));
                    }else{
                        data.add(new PieDataClass(ProjectsName,clientBillable));
                    }
               data.add(new PieDataClass('Not Filled',(totalHoursIn-(clientBillable+userInternal))));     
            }    
            
        }
        return (new PageReference('/apex/TimeEntryGraphicalView'));
    }
    
  //Table View
  public Pagereference tableView(){
    showHideIndividualView = true ;
    tableData = new List<DataTableClass>();
     String employee ;
     String projectName ;
     Decimal effort ;
     String description ;
    
    List<Time_Entry__c> timeEntryDetailList = [SELECT Date__c, Effort__c,Effort_Put_in_by_User__r.Name, Client_Recoverable__c,Project__r.Name,Activity_Description__c FROM Time_Entry__c WHERE Date__c >=: stDate AND Date__c <=: edDate AND CreatedById IN :userId]; 
        for(Time_Entry__c timeEntry : timeEntryDetailList){
            employee = timeEntry.Effort_Put_in_by_User__r.Name ;
            projectName = timeEntry.Project__r.Name ;
            effort = timeEntry.Effort__c ;
            description = timeEntry.Activity_Description__c ;
            tableData.add(new DataTableClass(employee,projectName,effort,description));
        }
      System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+ tableData);
    return (new Pagereference('/apex/TestTableView'));
  }  
}