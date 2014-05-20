@isTest(SeeAllData=true)
private class LM_LeaveRequestCalendarView_TestClass
{
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

 private static Testmethod void RequestCalenderView()
 {

init();


LM_LeaveRequest_Vivek1Controller LeaveRequest = new LM_LeaveRequest_Vivek1Controller();

LM_LeaveRequest_Vivek1Controller.dayList daylistclass = new LM_LeaveRequest_Vivek1Controller.dayList();
List<LM_LeaveRequest_Vivek1Controller.dayList> listOfWeekndsAndHoliday = new List<LM_LeaveRequest_Vivek1Controller.dayList>();
daylistclass.dayNumber=12;
daylistclass.typeCol='Applied';
listOfWeekndsAndHoliday.add(daylistclass);
LM_LeaveRequest_Vivek1Controller.leaveReq leavereqclass = new LM_LeaveRequest_Vivek1Controller.leaveReq(listOfWeekndsAndHoliday);
LM_LeaveRequest_Vivek1Controller.approveOrRejectLeave(testleave.id,'testing','Approved');
LM_LeaveRequest_Vivek1Controller.approveRecord(testleave.id,'testing');
LM_LeaveRequest_Vivek1Controller.getHolidaysForCurrentMonth(2013,03);



}
private static Testmethod void RequestCalenderViewrejected()
 {

init();


LM_LeaveRequest_Vivek1Controller LeaveRequest = new LM_LeaveRequest_Vivek1Controller();

LM_LeaveRequest_Vivek1Controller.dayList daylistclass = new LM_LeaveRequest_Vivek1Controller.dayList();
List<LM_LeaveRequest_Vivek1Controller.dayList> listOfWeekndsAndHoliday = new List<LM_LeaveRequest_Vivek1Controller.dayList>();
daylistclass.dayNumber=12;
daylistclass.typeCol='Applied';
listOfWeekndsAndHoliday.add(daylistclass);
LM_LeaveRequest_Vivek1Controller.leaveReq leavereqclass = new LM_LeaveRequest_Vivek1Controller.leaveReq(listOfWeekndsAndHoliday);
LM_LeaveRequest_Vivek1Controller.approveOrRejectLeave(testleave.id,'testing','Cancelled');
LM_LeaveRequest_Vivek1Controller.rejectRecord(testleave.id,'testing');

LM_LeaveRequest_Vivek1Controller.getHolidaysForCurrentMonth(2012,22);

}
}