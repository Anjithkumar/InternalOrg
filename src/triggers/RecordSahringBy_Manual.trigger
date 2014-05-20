trigger RecordSahringBy_Manual on Testsharing__c (after insert,after update) {

list<Id> allJobs=new List<Id>();
list<Id> createdById=new List<Id>();

  
   
     List<Testsharing__Share > jobShares  = new List<Testsharing__Share >();
    
      for(Testsharing__c job : trigger.new){
      
      //  Testsharing__Share hiringManagerShare = new Testsharing__Share ();      
           
     //   jobShares.add(hiringManagerShare);
     
         allJobs.add(job.Id);
         createdById.add(job.CreatedById);
         system.debug('------------------allJobs------------'+allJobs);
         system.debug('...................Created by Name-------------'+createdById);
      }
      
     jobShares =[select id,UserOrGroupId,ParentId from Testsharing__Share where ParentId in :allJobs];
     system.debug('......................jobShares------------'+jobShares );
     List<user> u=[select id,name,SharingUserId__c from user where id in :createdById and IsActive = true];
     
     system.debug('..................u..........'+u);
   
   
       RecordSahringBy.manualShareRead(jobShares,u);
     
   
   


}