public class WeeklyViewController 
{

     public String dateInStringFormat{get;set;}
    
    
    List<dayHourWrapper> wrapList;
    public Date startOfWeek{get;set;}
    public Date Mondate{get;set;}
    public Date TueDate{get;set;}
    public Date WedDate{get;set;}
    public Date ThuDate{get;set;}
    public Date FriDate{get;set;}
    public Date SatDate{get;set;}
    public List<Date> days{get;set;} 
    public Boolean isVisible{get;set;}
    public PageReference assignDate() 
    {
        if(dateInStringFormat!=''&&dateInStringFormat!=null)
        {
            System.debug('Blank Date '+dateInStringFormat);
            enteredDate = date.parse(dateInStringFormat);
            startOfWeek = enteredDate.toStartOfweek();
            Date endOfWeek = enteredDate.toStartOfweek().addDays(6);
            Mondate = startOfWeek+1;
            TueDate = startOfWeek+2;
            WedDate = startOfWeek+3;
            ThuDate = startOfWeek+4;
            FriDate = startOfWeek+5;
            SatDate = startOfWeek+6;
            List<Time_Entry__c> listOfTimeEntries = [select Id,Date__c,Effort__c,Activity_Description__c,Client_Recoverable__c,Effort_Put_in_By_User__c,Effort_Put_in_By_User__r.Name,Project__c,Related_Task__c,Related_Task__r.Name,Project__r.Name from Time_Entry__c where Effort_Put_in_By_User__c=:UserInfo.getUserId() AND Date__c>=:startOfWeek AND Date__c<=:endOfWeek order by Project__r.Name asc];
            //System.debug(listOfTimeEntries );
            String tempProj = '';  
            dayHourWrapper wrapInstance;  
            wrapList =  new List<dayHourWrapper>();  
            for(Time_Entry__c instance:listOfTimeEntries)
            {
                if(tempProj==''||instance.Project__r.Name!=tempProj)
                {
                    if(tempProj!=null)
                        {
                            wrapList.add(wrapInstance);
                        }
                        tempProj = instance.Project__r.Name;
                        wrapInstance=new dayHourWrapper();
                        wrapInstance.sundayEffort=0;
                        wrapInstance.mondayEffort=0;
                        wrapInstance.tuesdayEffort=0;
                        wrapInstance.wednesdayEffort=0;
                        wrapInstance.thursdayEffort=0;
                        wrapInstance.fridayEffort=0;
                        wrapInstance.saturdayEffort=0;
                        wrapInstance.ProjectName = tempProj;
                        if(startOfWeek.daysBetween(instance.Date__c)==0)
                        {
                            wrapInstance.sundayEffort=wrapInstance.sundayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==1)
                        {
                            wrapInstance.mondayEffort=wrapInstance.mondayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==2)
                        {
                            wrapInstance.tuesdayEffort=wrapInstance.tuesdayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==3)
                        {
                            wrapInstance.wednesdayEffort=wrapInstance.wednesdayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==4)
                        {
                            wrapInstance.thursdayEffort=wrapInstance.thursdayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==5)
                        {
                            wrapInstance.fridayEffort=wrapInstance.fridayEffort+instance.Effort__c;
                        }
                        else
                        {
                            wrapInstance.saturdayEffort=wrapInstance.saturdayEffort+instance.Effort__c;
                        }
                    }
                    else
                    {
                        if(startOfWeek.daysBetween(instance.Date__c)==0)
                        {
                            wrapInstance.sundayEffort=wrapInstance.sundayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==1)
                        {
                            wrapInstance.mondayEffort=wrapInstance.mondayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==2)
                        {
                            wrapInstance.tuesdayEffort=wrapInstance.tuesdayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==3)
                        {
                            wrapInstance.wednesdayEffort=wrapInstance.wednesdayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==4)
                        {
                            wrapInstance.thursdayEffort=wrapInstance.thursdayEffort+instance.Effort__c;
                        }
                        else if(startOfWeek.daysBetween(instance.Date__c)==5)
                        {
                            wrapInstance.fridayEffort=wrapInstance.fridayEffort+instance.Effort__c;
                        }
                        else
                        {
                            wrapInstance.saturdayEffort=wrapInstance.saturdayEffort+instance.Effort__c;
                        }
                    }
                    
                }
                wrapList.add(wrapInstance);
                System.debug(wrapInstance);
            }
            return null;
        }
    public class dayHourWrapper
    {
        public Decimal sundayEffort{get;set;}
        public Decimal mondayEffort{get;set;}
        public Decimal tuesdayEffort{get;set;}
        public Decimal wednesdayEffort{get;set;}
        public Decimal thursdayEffort{get;set;}
        public Decimal fridayEffort{get;set;}
        public Decimal saturdayEffort{get;set;}
        public String ProjectName{get;set;}
        
    }   
    
    
    public String timeEntryTab{get;set;}
    public String WeeklyViewTab{get;set;}
    public String BasicWizardTab{get;set;}
    public String Home{get;set;}
    Date enteredDate;
    public WeeklyViewController()
    {
        timeEntryTab='#';
        WeeklyViewTab='active';
        dateInStringFormat='';
        BasicWizardTab='#';
        Home='#';
    }
    public List<dayHourWrapper> getAllEntries()
    {
        return wrapList;
    }
    
}