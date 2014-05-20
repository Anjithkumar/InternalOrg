global class LM_birthdayremainder implements Database.Batchable<sObject>
{
               global  String userList;
      
   
   global Database.QueryLocator start(Database.BatchableContext BC){
       //system.debug('...........enter into loop');
     userList='Select id,name,DOB__c from User where DOB__c != null AND IsActive= true';
     // userHRList='Select id,name, Total_Leave__c from User where userrole.name=\' Developer\' AND Exit_Date__C= NULL';
                  return Database.getQueryLocator(userList);
              }

   global void execute(Database.BatchableContext BC, List<sObject> Scope)
   {
                  
              List<User> userHRList = new  List<User>();
             userHRList=[Select id from User where userrole.name= 'HR' AND IsActive= true ];
                 List<task> newTasks = new List<task>();
                 for(sObject sobjects : scope)
                 {
                    
                              User userSelectedList =(User)sobjects;
                              Integer birthday = userSelectedList.DOB__c.day();
                              Integer  customday = Date.Today().day();
                              Integer daydiff= birthday-customday;
                              if(userSelectedList.DOB__c!=null && userSelectedList.DOB__c.month()==date.Today().month()&& daydiff==2)
                              {
                              for(User hrList :userHRList  )
                              {
                              system.debug('***************************************************************'+userSelectedList.DOB__c);
                              Task birthdaytask = new Task(
                              OwnerId=hrList.id,
                           Subject=''+ userSelectedList.name +'s birthday is coming in next two days  ',
                           status = 'Not Started',
                           ActivityDate=System.Today(),
                           Priority='Normal');
                          // WhoId=userHRList.id);
                           newTasks.add(birthdaytask);

                           }
                      }
                      
                      }
                       
                if(newTasks.size()>0)
                {   
               insert(newTasks);   
            }
            }
            
     global void finish(Database.BatchableContext BC){
               
               
           }
}