global class LM_LeaveRequestCalendarClass_v3 {
    
    public PageReference test() 
    {
        next();
        system.debug('inhere#');
        //system.assertequals('', null);
        return null;
    }
    
    
    
    public Integer lastDayValue { get; set; }
    public Boolean renderSection2 { get; set; }
    Date dateParam;
    Date firstDayOfMonth;
    Date lastDayOfMonth;
    id roleId=userinfo.getUserRoleId();
    id userId=userinfo.getUserId();
    String userName=userinfo.getUserName();
    public String selectedYear { get; set; }
    public String selectedMonth { get; set; }
    
    public class HeaderWrapper{
        public String dayOfMonth{get;set;}
        public String colorCode{get;set;}
    }
    public Map<String,HeaderWrapper> headerValues {get;set;}
    List<LeaveDetails_WrapperClass> listOfEmployeeLeaves = new List<LeaveDetails_WrapperClass>();
    
    public class LeaveDetails_WrapperClass{
        
        public String employeeName {get;set;}
        Set<String> leaveDates = new Set<String>();
        public Map<String,String> leavedatesMap {get;set;}
        public Map<String,String> dateLeaveRecMap {get;set;}
        public Map<String,String> StylingMap {get;set;}
        public Map<String,Leave_Request__c> leaveRequestDetails{get;set;}
        //Public List<Leave_Request__c> leaveRequestDetails {get;set;}
    }
    
    public LM_LeaveRequestCalendarClass_V3()
    {
        renderSection2 = false;
    }
    
    public List<LeaveDetails_WrapperClass> getEmployeeLeaveDetails()
    {
        
        listOfEmployeeLeaves =  new List<LeaveDetails_WrapperClass>();
        if(firstDayOfMonth != null){
            user  usr = [select Name,profileid,user.profile.name from user where id =:userId];
            system.debug(usr.name);
            //  soql = 'Select id,name, Total_Leave__c from User where userrole.name=\'Developer\' AND Exit_Date__C= NULL';
            if(usr.profile.name == 'System Administrator'){
                List<User> allEmployees=[select id, name,Total_Leave__c,Exit_Date__c from user where isActive=true]; 
            }
            List<User> allEmployees=[Select id,Name,UserRoleId,Total_Leave__c,Exit_Date__c,UserRole.Name,user.profile.name from User where ((  Exit_Date__C= NULL AND IsActive=true))];
            String employeeId = null;
            List<Leave_Request__c> leaveRequestsForMonth = [ select id,Employee__c,Employee__r.Name,End_date__c,Start_Date__c,Comment__c,Reason_for_Leave__c,Status__c from Leave_Request__c where (CALENDAR_MONTH(Start_Date__c) = :Integer.valueOf(selectedMonth) OR CALENDAR_MONTH(End_Date__c) = :Integer.valueOf(selectedMonth)) AND CALENDAR_YEAR(Start_Date__c) = :Integer.valueOf(selectedYear) And Employee__c IN:allEmployees order by Employee__c,Start_Date__c];
            LeaveDetails_WrapperClass leaveDetailInstance;
            for(Leave_Request__c leaveReq : leaveRequestsForMonth){
                if(employeeId == null){
                    leaveDetailInstance = new LeaveDetails_WrapperClass();
                    employeeId = leaveReq.Employee__c;
                    leaveDetailInstance.leavedatesMap = new Map<String,String>{'1'=>'0','2'=>'0','3'=>'0','4'=>'0','5'=>'0','6'=>'0','7'=>'0','8'=>'0','9'=>'0','10'=>'0','11'=>'0','12'=>'0','13'=>'0','14'=>'0','15'=>'0','16'=>'0','17'=>'0','18'=>'0','19'=>'0','20'=>'0','21'=>'0','22'=>'0','23'=>'0','24'=>'0','25'=>'0','26'=>'0','27'=>'0','28'=>'0','29'=>'0','30'=>'0','31'=>'0'};
                        leaveDetailInstance.dateLeaveRecMap =  new Map<String,String>{'1'=>'0','2'=>'0','3'=>'0','4'=>'0','5'=>'0','6'=>'0','7'=>'0','8'=>'0','9'=>'0','10'=>'0','11'=>'0','12'=>'0','13'=>'0','14'=>'0','15'=>'0','16'=>'0','17'=>'0','18'=>'0','19'=>'0','20'=>'0','21'=>'0','22'=>'0','23'=>'0','24'=>'0','25'=>'0','26'=>'0','27'=>'0','28'=>'0','29'=>'0','30'=>'0','31'=>'0'};
                            leaveDetailInstance.StylingMap  = new Map<String,String>{'1'=>'','2'=>'','3'=>'','4'=>'','5'=>'','6'=>'','7'=>'','8'=>'','9'=>'','10'=>'','11'=>'','12'=>'','13'=>'','14'=>'','15'=>'','16'=>'','17'=>'','18'=>'','19'=>'','20'=>'','21'=>'','22'=>'','23'=>'','24'=>'','25'=>'','26'=>'','27'=>'','28'=>'','29'=>'','30'=>'','31'=>''};
                                leaveDetailInstance.leaveRequestDetails  = new Map<String,Leave_Request__c>{'1'=> new Leave_Request__c(),'2'=>new Leave_Request__c(),'3'=> new Leave_Request__c(),'4'=>new Leave_Request__c(),'5'=>new Leave_Request__c(),'6'=>new Leave_Request__c(),'7'=> new Leave_Request__c(),'8'=>new Leave_Request__c(),'9'=>new Leave_Request__c(),'10'=>new Leave_Request__c(),'11'=>new Leave_Request__c(),'12'=>new Leave_Request__c(),'13'=>new Leave_Request__c(),'14'=>new Leave_Request__c(),'15'=>new Leave_Request__c(),'16'=>new Leave_Request__c(),'17'=>new Leave_Request__c(),'18'=>new Leave_Request__c(),'19'=>new Leave_Request__c(),'20'=>new Leave_Request__c(),'21'=>new Leave_Request__c(),'22'=>new Leave_Request__c(),'23'=>new Leave_Request__c(),'24'=>new Leave_Request__c(),'25'=>new Leave_Request__c(),'26'=>new Leave_Request__c(),'27'=>new Leave_Request__c(),'28'=>new Leave_Request__c(),'29'=>new Leave_Request__c(),'30'=>new Leave_Request__c(),'31'=>new Leave_Request__c()};
                                    
                                    
                                    }
                else if (employeeId != leaveReq.Employee__c){
                    listOfEmployeeLeaves.add(leaveDetailInstance);
                    leaveDetailInstance = new LeaveDetails_WrapperClass();
                    leaveDetailInstance.dateLeaveRecMap = new Map<String,String>{'1'=>'0','2'=>'0','3'=>'0','4'=>'0','5'=>'0','6'=>'0','7'=>'0','8'=>'0','9'=>'0','10'=>'0','11'=>'0','12'=>'0','13'=>'0','14'=>'0','15'=>'0','16'=>'0','17'=>'0','18'=>'0','19'=>'0','20'=>'0','21'=>'0','22'=>'0','23'=>'0','24'=>'0','25'=>'0','26'=>'0','27'=>'0','28'=>'0','29'=>'0','30'=>'0','31'=>'0'};
                        leaveDetailInstance.leavedatesMap = new Map<String,String>{'1'=>'0','2'=>'0','3'=>'0','4'=>'0','5'=>'0','6'=>'0','7'=>'0','8'=>'0','9'=>'0','10'=>'0','11'=>'0','12'=>'0','13'=>'0','14'=>'0','15'=>'0','16'=>'0','17'=>'0','18'=>'0','19'=>'0','20'=>'0','21'=>'0','22'=>'0','23'=>'0','24'=>'0','25'=>'0','26'=>'0','27'=>'0','28'=>'0','29'=>'0','30'=>'0','31'=>'0'};
                            leaveDetailInstance.StylingMap  = new Map<String,String>{'1'=>'','2'=>'','3'=>'','4'=>'','5'=>'','6'=>'','7'=>'','8'=>'','9'=>'','10'=>'','11'=>'','12'=>'','13'=>'','14'=>'','15'=>'','16'=>'','17'=>'','18'=>'','19'=>'','20'=>'','21'=>'','22'=>'','23'=>'','24'=>'','25'=>'','26'=>'','27'=>'','28'=>'','29'=>'','30'=>'','31'=>''};
                                leaveDetailInstance.leaveRequestDetails  = new Map<String,Leave_Request__c>{'1'=> new Leave_Request__c(),'2'=>new Leave_Request__c(),'3'=> new Leave_Request__c(),'4'=>new Leave_Request__c(),'5'=>new Leave_Request__c(),'6'=>new Leave_Request__c(),'7'=> new Leave_Request__c(),'8'=>new Leave_Request__c(),'9'=>new Leave_Request__c(),'10'=>new Leave_Request__c(),'11'=>new Leave_Request__c(),'12'=>new Leave_Request__c(),'13'=>new Leave_Request__c(),'14'=>new Leave_Request__c(),'15'=>new Leave_Request__c(),'16'=>new Leave_Request__c(),'17'=>new Leave_Request__c(),'18'=>new Leave_Request__c(),'19'=>new Leave_Request__c(),'20'=>new Leave_Request__c(),'21'=>new Leave_Request__c(),'22'=>new Leave_Request__c(),'23'=>new Leave_Request__c(),'24'=>new Leave_Request__c(),'25'=>new Leave_Request__c(),'26'=>new Leave_Request__c(),'27'=>new Leave_Request__c(),'28'=>new Leave_Request__c(),'29'=>new Leave_Request__c(),'30'=>new Leave_Request__c(),'31'=>new Leave_Request__c()};
                                    
                                    employeeId = leaveReq.Employee__c;
                    
                    //leaveDetailInstance.leaveRequestDetails.put(leaveReq.Id,leaveReq);
                    //leaveDetailInstance.leaveRequestDetails.add(leaveReq);
                    
                }
                leaveDetailInstance.employeeName = leaveReq.Employee__r.Name;
                String colorCode ='';
                String styleClass;
                //  if(leaveReq.Status__c)
                if(leaveReq.Status__c == 'applied'){
                    //colorCode = '#FFFF00'; // yellow
                    styleClass='appliedLeave';
                }
                else if(leaveReq.Status__c == 'Cancelled'){
                    //colorCode = '#FF0000'; // red
                    styleClass='cancelled';
                }
                else {
                    //colorCode = '#008000'; //green
                    styleClass='approved';
                }
                
                Integer startDate =0;
                Integer endDate =0;
                if(leaveReq.Start_Date__c.month() != leaveReq.End_Date__c.month()){
                    if(leaveReq.Start_Date__c.month() < Integer.valueOf(selectedMonth)){
                        startDate = 1;
                        endDate = leaveReq.End_date__c.day();
                    }
                    else if(leaveReq.End_Date__c.month() > Integer.valueOf(selectedMonth)){
                        startDate = leaveReq.Start_Date__c.day();
                        endDate = date.daysInMonth(Integer.valueOf(selectedYear), Integer.valueOf(selectedMonth));
                    } 
                }
                else{
                    startDate = leaveReq.Start_Date__c.day();
                    endDate = leaveReq.End_date__c.day();
                }
                for(Integer i=startDate;i<=EndDate;i++){
                    leaveDetailInstance.leavedatesMap.put(String.valueOf(i),colorCode);
                    leaveDetailInstance.dateLeaveRecMap.put(String.valueOf(i),URL.getSalesforceBaseUrl().toExternalForm() +'/' + leaveReq.Id);
                    leaveDetailInstance.StylingMap.put(String.valueOf(i),styleClass);
                    leaveDetailInstance.leaveRequestDetails.put(String.valueOf(i),leaveReq);
                    
                }  
            }
            listOfEmployeeLeaves.add(leaveDetailInstance);
        }
        return listOfEmployeeLeaves;
    }
    public List<SelectOption> getTotalMonths() {
        List<SelectOption> options = new List<SelectOption>();
        string[] mnth=new string[]{'January','February','March','April','May','June','July','August','September','October','November','December'};
            
            options.add(new SelectOption(string.valueOf(date.today().Month()),mnth[Integer.valueOf(date.today().Month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(1).month()),mnth[Integer.valueOf(date.today().addMonths(1).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(2).month()),mnth[Integer.valueOf(date.today().addMonths(2).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(3).month()),mnth[Integer.valueOf(date.today().addMonths(3).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(4).month()),mnth[Integer.valueOf(date.today().addMonths(4).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(5).month()),mnth[Integer.valueOf(date.today().addMonths(5).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(6).month()),mnth[Integer.valueOf(date.today().addMonths(6).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(7).month()),mnth[Integer.valueOf(date.today().addMonths(7).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(8).month()),mnth[Integer.valueOf(date.today().addMonths(8).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(9).month()),mnth[Integer.valueOf(date.today().addMonths(9).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(10).month()),mnth[Integer.valueOf(date.today().addMonths(10).month()-1)]));
        options.add(new SelectOption(string.valueOf(date.today().addMonths(11).month()),mnth[Integer.valueOf(date.today().addMonths(11).month()-1)]));
        //options.add(new SelectOption(string.valueOf(date.today().addMonths(12).month()),mnth[Integer.valueOf(date.today().addMonths(12).month()-1)]));
        
        return options;
    }
    public List<SelectOption> getTotalYears() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(string.valueOf(date.today().year()),String.valueOf(date.today().year())));
        options.add(new SelectOption(string.valueOf(date.today().addyears(-1).year()),String.valueOf(date.today().addyears(-1).year())));
        options.add(new SelectOption(string.valueOf(date.today().addyears(-2).year()),String.valueOf(date.today().addyears(-2).year())));
        options.add(new SelectOption(string.valueOf(date.today().addyears(-3).year()),String.valueOf(date.today().addyears(-3).year())));
        options.add(new SelectOption(string.valueOf(date.today().addyears(-4).year()),String.valueOf(date.today().addyears(-4).year())));
        options.add(new SelectOption(string.valueOf(date.today().addyears(-5).year()),String.valueOf(date.today().addyears(-5).year())));
        options.add(new SelectOption(string.valueOf(date.today().addyears(-6).year()),String.valueOf(date.today().addyears(-6).year())));
        return options;
    }
    public PageReference next() {
        renderSection2 = true;
        system.debug('inhere#');
        headerValues = new Map<String,HeaderWrapper>();
        if(selectedYear != null && selectedMonth != null ){
            firstDayOfMonth = date.newInstance(Integer.valueOf(selectedYear),Integer.valueOf(selectedMonth),01); //1
            lastDayValue = Date.daysInMonth(Integer.valueOf(selectedYear),Integer.valueOf(selectedMonth));//30
            lastDayOfMonth = date.newInstance(Integer.valueOf(selectedYear),Integer.valueOf(selectedMonth),lastDayValue); //30
            integer weekStart = firstDayOfMonth.toStartofWeek().daysBetween(firstDayOfMonth);
            Set<Date> holidayDates = new Set<Date>();
            for(Holiday holiday : [Select ActivityDate From Holiday]){
                holidayDates.add(holiday.ActivityDate);
            }
            for(Integer i = 0; i< Date.daysInMonth(Integer.valueOf(selectedYear),Integer.valueOf(selectedMonth)); i++){
                HeaderWrapper h = new HeaderWrapper();
                h.dayOfMonth = firstDayOfMonth.addDays(i).day().format();
                if(holidayDates.contains(firstDayOfMonth.addDays(i)) || firstDayOfMonth.addDays(i).toStartOfWeek().daysBetween(firstDayOfMonth.addDays(i)) == 6 || (firstDayOfMonth.addDays(i).toStartOfWeek().daysBetween(firstDayOfMonth.addDays(i)) == 0)){
                    h.colorCode = '#808080';
                    //h.colorCode = 'holiday';
                }
                headerValues.put(String.valueOf(i),h);
                //StylingMap.put(String.valueOf(i),h);
            }
            
        }
        return null;
    }
    
    public String getMonthName()
    {
        if(selectedMonth!= null)
        {
            Integer month = Integer.valueOf(selectedMonth);
            return (month<=6)?((month<=3)?((month<2)?'January':((month==2)?'February':'March')):((month<5)?'April':((month==5)?'May':'June'))):((month<=9)?((month<8)?'July':((month==8)?'August':'September')):((month<11)?'October':((month==11)?'November':'December')));
                }
        return null;
    } 
    
    
    //Approval Process 
    public static Id getWorkItemId(Id targetObjectId)
    {
        Id retVal = null;
        
        for(ProcessInstanceWorkitem workItem  : [Select p.Id from ProcessInstanceWorkitem p
                                                 where p.ProcessInstance.TargetObjectId =: targetObjectId])
        {
            retVal  =  workItem.Id;
        }
        
        return retVal;
    }
    //approve request
    @RemoteAction
        global static  void approveRecord(String leaveReq,String comments)
    {
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setComments(comments);
        req.setAction('Approve');
        req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        Id workItemId = getWorkItemId(leaveReq);
        //opp.addError(workItemId);
        
        if(workItemId == null)
        {
            
        }
        else
        {
            req.setWorkitemId(workItemId);
            // Submit the request for approval
            Approval.ProcessResult result =  Approval.process(req);
        }
    }
    
    //reject process 
    @RemoteAction
        global static void rejectRecord(String leaveReq,String comments)
    {
        Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
        req.setComments(comments);
        req.setAction('Reject');
        //req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        Id workItemId = getWorkItemId(leaveReq);
        //opp.addError(workItemId);
        
        if(workItemId == null)
        {
            
        }
        else
        {
            req.setWorkitemId(workItemId);
            //Submit the request for approval
            Approval.ProcessResult result =  Approval.process(req);
        }
    }
    
    
    
    
    
    
    
}