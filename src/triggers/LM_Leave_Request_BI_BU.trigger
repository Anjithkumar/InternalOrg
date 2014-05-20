/* Trigger to restrict user to  submit leave on already applied range of dates */

trigger LM_Leave_Request_BI_BU on Leave_Request__c (Before insert,Before update) {
    List<Leave_Request__c> currentLeaveReq = new List<Leave_Request__c>();
    Set<id> employeeIds= new Set<id>();
    Map<Id,User> employeeDetails = new Map<Id,User>();
    
    String name;
    
    for(Leave_Request__c leaveRec:Trigger.new)
    {
        employeeIds.add(leaveRec.Employee__c);
    }
    for(User c : [select Id,Name, Total_Leave__c from User where Id in :employeeIds ]){
        employeeDetails.put(c.Id,c);
    }
    for(Leave_Request__c leaveRec:Trigger.new)
    {
        Boolean isValidLeave = LM_UtilityClass.validateLeaveRange(leaveRec.Start_Date__c, leaveRec.End_Date__c, leaveRec.Employee__c,leaveRec.Id);
        if(isValidLeave == false){
            leaveRec.addError('You have already applied leave in the range currently specified. Please ensure your leaves don\'t overlap.');
        }
        if(Trigger.isUpdate){
            if(Trigger.oldMap.get(leaveRec.Id).Start_Date__c != leaveRec.Start_Date__c || Trigger.oldMap.get(leaveRec.Id).End_Date__c != leaveRec.End_Date__c && Trigger.oldMap.get(leaveRec.Id).Status__c!='Cancelled' ){
                currentLeaveReq.add(leaveRec);
                leaveRec.Total_Working_days__c = LM_UtilityClass.getweekDayCount(leaveRec.Start_Date__c, leaveRec.End_Date__c);
                Decimal leaveBalance = employeeDetails.get(leaveRec.Employee__c).Total_Leave__c - leaveRec.Total_Working_days__c;
                if ( leaveBalance <0)
                {
                    leaveRec.Number_of_Days_LOP__c = Math.abs(leaveBalance);
                    leaveRec.Lop__c = true;
                    //leaveRec.addError('You do not have sufficient leave balance to apply these leaves.');
                    
                }
            }
        }
        else{
            currentLeaveReq.add(leaveRec);
            employeeIds.add(leaveRec.Employee__c);
            leaveRec.Total_Working_days__c = LM_UtilityClass.getweekDayCount(leaveRec.Start_Date__c, leaveRec.End_Date__c);
            Decimal leaveBalance = employeeDetails.get(leaveRec.Employee__c).Total_Leave__c - leaveRec.Total_Working_days__c;
            if ( leaveBalance <0)
            {
                leaveRec.Number_of_Days_LOP__c = Math.abs(leaveBalance);
                leaveRec.Lop__c = true;
                //leaveRec.addError('You do not have sufficient leave balance to apply these leaves.');
                
            }
        }
    } 
}