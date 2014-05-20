global with sharing class LM_LeaveRequest_Vivek1Controller {
    
    
    
    @RemoteAction
    global static String approveOrRejectLeave(String recId,String comm,String statusL) 
    {
    
    Leave_Request__c lq = [Select id,Name,Status__c,Comment__c from Leave_Request__c where id=:recId];
    lq.Status__c = statusL;
    lq.Comment__c = comm;
    update lq;
    
    if(lq.Status__c =='Approved')
    {
    
    approveRecord(lq.Id,lq.Comment__c);
    } 
    
    else if(lq.Status__c =='Cancelled')
    {
    rejectRecord(lq.Id,lq.Comment__c);
    }
    return '';
    }
    
    @RemoteAction
    global static List<leaveReq> getHolidaysForCurrentMonth(Integer yr,Integer mn) {
         
        Set<Integer>  dlSet = new Set<Integer>();
        Set<Integer>  hlList = new Set<Integer>(); 
        Integer en =  date.daysInMonth(yr, mn);
        List<leaveReq> tableList = new List<leaveReq>(); 
        for(Holiday d : [Select ActivityDate From Holiday where ActivityDate >= :date.newinstance(yr,mn,1) and ActivityDate <= :date.newinstance(yr,mn,en)]){
            dlSet.add(d.ActivityDate.day());      
        }
        
        List<dayList> listOfWeekndsAndHoliday = new List<dayList>();
        for(Integer i=1;i<=en;i++){
         //leaveReq lreq = new leaveReq();
         //lreq 
         dayList dl = new dayList();
         DateTime dt=DateTime.newInstance(date.newInstance(yr,mn,i), Time.newInstance(0, 0, 0, 0));
         String dayOfWeek = dt.format('EEE');
         if(dlSet.contains(i)){
              if(dayOfWeek == 'Sun' || dayOfWeek == 'Sat'){
              system.debug('First Loop');
              dl.dayNumber = i;
              dl.typeCol = 'Holiday';
              }else{
              dl.dayNumber = i;
              dl.typeCol = 'Holiday';
              
              }
          
         }else if(dayOfWeek == 'Sun' || dayOfWeek == 'Sat' ){
              system.debug('Second Loop');
              dl.dayNumber = i;
              dl.typeCol = 'Holiday';
         
         }else{
              dl.dayNumber = i;
              dl.typeCol = 'Normal';
         
         }
        listOfWeekndsAndHoliday.add(dl);
        }
        
        leaveReq firstRow = new leaveReq(listOfWeekndsAndHoliday);
        firstRow.EmpName = 'Emp Name';
        //firstRow.dayMon = listOfWeekndsAndHoliday;
        firstRow.yr = yr;
        firstRow.mn = mn;
        firstRow.lqId = '';
        tablelist.add(firstRow);
        
        
        
        List<Leave_Request__c> leaveRequestsForMonth = [ select id,Employee__c,Employee__r.FirstName,Employee__r.Name,End_date__c,Start_Date__c,Comment__c,Reason_for_Leave__c,Status__c from Leave_Request__c where (CALENDAR_MONTH(Start_Date__c) = :mn OR CALENDAR_MONTH(End_Date__c) = :mn) AND (CALENDAR_YEAR(Start_Date__c) = :yr OR CALENDAR_YEAR(End_Date__c) = :yr) order by Employee__c,Start_Date__c];
        for(Leave_Request__c l : leaveRequestsForMonth){
                Integer diff = 0;
                system.debug(l.Start_Date__c +'SDate');
                 List<dayList> clonedList = new List<dayList>();
                 //clonedList.addAll(listOfWeekndsAndHoliday);
                 //system.debug(clonedList+'At First');
                
                if(l.Start_Date__c.Month() == l.End_date__c.Month()){
                  diff = l.End_date__c.day()- l.Start_Date__c.day() ;
                  //system.debug(l.End_date__c.day() + '' + l.Start_Date__c.day());
                }else{            
                   diff = l.End_Date__c.day();                   
                }
                system.debug(diff + 'DIFFF');
                Set<Integer> sequence = new Set<Integer>();
                if(mn==l.Start_Date__c.month() && yr==l.Start_Date__c.year()){
                for(Integer st = (l.Start_Date__c.day()-1);st < (l.Start_Date__c.day() + diff);st++){
                        sequence.add(st);     
                        System.debug(sequence  +'Narayana');                 
                }
               }else if(yr==l.End_Date__c.year() && mn==l.End_Date__c.month()){
               for(Integer st=0;st < l.End_Date__c.day();st++){
               sequence.add(st);
               System.debug(sequence +'Narayana123');
               }
                
                }
                
          if(sequence.size()>0){
                for(Integer dd = 0;dd < en;dd++)
                {
                dayList dlt = new dayList();
                      dlt.dayNumber = (dd+1);
                    if(listOfWeekndsAndHoliday[dd].typeCol == 'Holiday'){
                      dlt.typeCol = 'Holiday';
                    }
                    else if((l.Start_Date__c.day()-1) == dd){
                      dlt.typeCol = l.Status__c;
                    }else if(sequence.contains(dd)){
                      dlt.typeCol = l.Status__c;
                    }
                clonedList.add(dlt);
                }
                }
                /*if(diff == 0){
                 if(clonedList[(l.Start_Date__c.day()-1)].typeCol == 'Normal'){
                    clonedList[(l.Start_Date__c.day()-1)].typeCol = l.Status__c;
                 }
                }else{
                system.debug('IN Else'+l.Start_Date__c.day() + ''+ diff);
                
                for(Integer st = (l.Start_Date__c.day()-1);st < (l.Start_Date__c.day() + diff);st++){
                 system.debug(clonedList[st].typeCol + 'IN THIS');
                 if(clonedList[st].typeCol == 'Normal'){
                    clonedList[st].typeCol = l.Status__c;
                 } 
                system.debug(clonedList[st].typeCol + 'PART 2');                              
                }
                }
                */
                       if(clonedList.size()>0){
                leaveReq remRow = new leaveReq(clonedList);
                remRow.EmpName = l.Employee__r.FirstName;
                //remRow.dayMon = clonedList;
                remRow.yr = yr;
                remRow.mn = mn;
                remRow.lqId = l.Id;
                system.debug(tablelist +'MONTH123');
                tablelist.add(remRow);
                //clonedList.clear();
               
             }   
                
        }
        
        //system.debug('First Loop'+listOfWeekndsAndHoliday);
        
        
     return tableList; 
    }

    
    
    global class leaveReq{
    
    public String EmpName {get;set;}
    public List<dayList> dayMon = new List<dayList>();
    public Integer yr {get;set;}
    public Integer mn {get;set;}   
    public String lqId {get;set;} 
    
    public leaveReq(List<dayList> dt){
    dayMon = dt;
    }
    
    }
    
    global class dayList{
    public Integer dayNumber {get;set;}
    public String typeCol {get;set;}
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
    //@RemoteAction
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
    //@RemoteAction
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