trigger LM_User_BI on User (Before insert){
    Integer Ismonth;
    Integer Isyear;
    Integer Isday=1;
    
    LM_CustomSetting__c currentYear = [Select No_Of_Annual_Leaves__c, Frequncy_Of_Run__c from LM_CustomSetting__c where Active__c = true limit 1];
      List<String> monthsToConsider = currentYear.Frequncy_Of_Run__c.split(';');
     Integer noOfDaysToAdd =monthsToConsider.size() ;
  
   //String extentorAccountName = [Select id from userrole  where name='Developer'  limit 1].id;
  // String extentorAccountName = [Select id from Account where name='Extentor'];
   for(User con :  trigger.new){
         if(con.Date_of_Joining__c!=null )//&& con.userroleid == extentorAccountName  )
         {                                
       //System.AssertEquals(con.accountid,extentorAccountName);
       
        List<Integer> ListfromString = new List<Integer>();
        
       for(String temp :monthsToConsider){
                ListfromString.add(Integer.valueOf(temp));
                }
        ListfromString.sort();
        
        for(Integer i=0;i<ListfromString.size();i++){
                
                 if (con.Date_of_Joining__c.month()< ListfromString[i]){
                            Ismonth = ListfromString[i];
                            break;
                        }
                else    {
                    
                        }
                }
                if(Ismonth==null){
                    Isday=31;
                    Ismonth=12;
                }
        Decimal day1,day2;
        Isyear = con.Date_of_Joining__c.year();
        Date NewDate = date.newinstance(Isyear,Ismonth , Isday);
        day1=con.Date_of_Joining__c.dayOfYear();
        day2=NewDate.dayOfYear();
        con.Total_Leave__c=((day2-day1))*(currentYear.No_Of_Annual_Leaves__c/noOfDaysToAdd)/(365/noOfDaysToAdd);
        con.Total_Leave__c=con.Total_Leave__c.round();
                    
         }

     }

}