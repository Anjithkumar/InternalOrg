global class LM_ApplicationLeaveClass {
    
    public Leave_Request__c leaveRequestRecord;
    public User users{get;set;}
    public list<Leave_Request__c> leaveRequestFetch{get;set;}
    Integer allDaysBetween;
    public  Leave_Request__c getLeave(){
        leaveRequestRecord = new Leave_Request__c();
        return leaveRequestRecord;
    } 
    
    
    public LM_ApplicationLeaveClass (ApexPages.StandardController controller) {
        resetQueries();
    }
    
    public void resetQueries(){
        id userId ;
        userId  = ApexPages.currentPage().getParameters().get('conid');
        if(userId  == null){
            userId  = UserInfo.getUserId();
        }
        users=[select id, name,Project_Lead__c,Total_Leave__c,Reports_to_ManagerHR__c  from user where id=:userId][0];
        leaveRequestFetch=[select id,Name,Employee__c,Project_Lead__c, Start_Date__c, End_Date__c, Status__c, LOP__c ,Number_of_Days_LOP__c, Total_Working_days__c, Reason_for_Leave__c from Leave_Request__c where Employee__c= :userId   and END_Date__c = THIS_YEAR order by Start_Date__c desc];
    }
    
    
    public pageReference save()
    {
        try{
            Decimal totalLeaves;
            leaveRequestRecord.Employee__c=users.id;
            leaveRequestRecord.Project_Lead__c=users.Project_Lead__c;
            Database.saveResult result = database.insert(leaveRequestRecord);
            if(result.success){
                Leave_Request__c insertedRec = [select LOP__c,Number_of_Days_LOP__c from Leave_Request__c where Id = :result.id];
                if(insertedRec .LOP__c){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Leave applied sucessfully.' + insertedRec.Number_of_Days_LOP__c +' day(s) has/have been marked as LOP. Contact HR for more details'));
                }
                else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Leave applied sucessfully'));
                }
                resetQueries();
                
            }
            
            return null;
            
        }
        catch (Exception ex) {
            ApexPages.addMessages(ex);
            return null;
        }
    }
    
    
}