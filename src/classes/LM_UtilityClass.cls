public class LM_UtilityClass {
    
    static  Integer weekdayCount;
    static Integer allWorkingDays;
    static Integer allDaysBetween;
    
    
    
    public static Integer getweekDayCount(Date startSate,Date endDate){ 
        weekdayCount  = calculateWorkingDaysBetweenTwoDates(startSate,endDate);
        //leaveRequestRecord.Total_Working_days__c = weekdayCount;
        return weekdayCount;
    }
    
    static Integer calculateWorkingDaysBetweenTwoDates(Date date1,Date date2){
        List<Holiday> holidays=[Select h.StartTimeInMinutes, h.Name, h.ActivityDate From Holiday h];
        allDaysBetween = date1.daysBetween(date2);
        allWorkingDays=0;
        
        for(Integer k=0;k<=allDaysBetween ;k++ ){
            if(checkifItisWorkingDay(date1.addDays(k),holidays)){
                allWorkingDays++;
            } 
        }
        return allWorkingDays;
    }
    
    public static boolean checkifItisWorkingDay(Date currentDate,List<Holiday> holidays){
        Date weekStart  = currentDate.toStartofWeek();
        for(Holiday hDay:holidays){
            if(currentDate.daysBetween(hDay.ActivityDate) == 0){
                return false;
            }
        }
        if(weekStart.daysBetween(currentDate) ==0 || weekStart.daysBetween(currentDate) == 6){
            return false;
        } 
        else 
            return true;
    }
    
    public static boolean validateLeaveRange(Date startDate, Date endDate, Id employeeId, Id leaveRequestId){
        Boolean isvalidLeave = true;
        for(Leave_Request__c prevLeaveReqest :[select id,Status__c,Start_Date__c, End_Date__c,Employee__c from Leave_Request__c where  Employee__c = :employeeId AND Start_Date__c = THIS_YEAR AND (Status__c ='Approved' OR Status__c ='Applied')]){
            Date LR_StartDate = prevLeaveReqest.Start_Date__c;
            Date LR_EndDate = prevLeaveReqest.End_Date__c;
            if(leaveRequestId !=prevLeaveReqest.Id){
                if((startDate<=LR_StartDate && LR_StartDate<=endDate)||(startDate<=LR_EndDate && LR_EndDate<=endDate)||(LR_StartDate <= startDate && startDate<=LR_EndDate) || (LR_StartDate<= endDate &&  endDate<=LR_EndDate )){
                    isvalidLeave = false;
                    break;
                }
            }
        }
        return isValidLeave;
    }
    
}