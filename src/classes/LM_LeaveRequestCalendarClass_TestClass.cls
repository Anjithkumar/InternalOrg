@isTest(SeeAllData=true)
private class LM_LeaveRequestCalendarClass_TestClass{
    // private static account testaccount;
    //  private static contact testcontact;
    private static user testUser;
    private static Leave_Request__c testleave;
    
    private static void init()
   {
   User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        System.runAs (thisUser)
        { 
        
            //String extentorAccountid = [Select id from userrole  where name='Developer'  limit 1].id;
            testUser=InitializeTestData.createUser('user5@testorg.com');
            //testUser.UserRoleId=extentorAccountid;
            testUser.Date_of_Joining__c=date.today();
            testUser.Total_Leave__c=21;
            Database.insert(testUser);
        }
         
          Date startDate=Date.newInstance(date.today().year(),07,03);
        Date endDate=Date.newInstance(date.today().year(),07,07);
        testleave=InitializeTestData.createLeaveRequest(testUser.id,startDate,endDate);
        database.insert(testleave);
       
       }
    
    
    private static Testmethod void RequestCalender(){
        init();
        
        LM_LeaveRequestCalendarClass_v3  leaveRequestCalendar=  new LM_LeaveRequestCalendarClass_v3 ();
        LM_LeaveRequestCalendarClass_v3.LeaveDetails_WrapperClass leavedetail=new LM_LeaveRequestCalendarClass_v3.LeaveDetails_WrapperClass();
        leaveRequestCalendar.selectedMonth = '7';
        leaveRequestCalendar.selectedYear = String.valueOf(date.today().year());
        leaveRequestCalendar.next();
        leaveRequestCalendar.getEmployeeLeaveDetails();
        //  List<Contact> allEmployees = [select id, name from Contact where Account.name='Extentor' and Exit_date__c = null ORDER BY name ASC];
        String employeeId = null;
        // List<Leave_Request__c> leaveRequestsForMonth = [ select Employee__c,Employee__r.Name,End_date__c,Start_Date__c,Status__c from Leave_Request__c where (CALENDAR_MONTH(Start_Date__c) = :Integer.valueOf(selectedMonth) OR CALENDAR_MONTH(End_Date__c) = :Integer.valueOf(selectedMonth)) AND CALENDAR_YEAR(Start_Date__c) = :Integer.valueOf(selectedYear) order by Employee__c,Start_Date__c];
        leaveRequestCalendar.getTotalMonths();
        leaveRequestCalendar.getTotalYears();
        leaveRequestCalendar.getMonthName();
        leaveRequestCalendar.next();
        leaveRequestCalendar.test();
   LM_LeaveRequestCalendarClass_v3.approveRecord(testleave.id,'testing');
LM_LeaveRequestCalendarClass_v3.rejectRecord(testleave.id,'testing');
    }
}