@isTest
public class BadgeAssignmentReportController_Test{
	private  static testmethod void BadgeAssignmentReportController(){
        
// Creating instance for our classl
    BadgeAssignmentReportController BARC =new BadgeAssignmentReportController();
//Create Integers from our local time
        
    dateTime dt=Datetime.now();   
     String testDate = dt.format('mm/dd/yyyy');                      
        	BARC.un = 'ghg';
            BARC.toDate = testDate;  
            BARC.fromDate = testDate;
       

            BARC.generateBadgeReport();
           BARC.getPickvaluesTest();  
        
}
}