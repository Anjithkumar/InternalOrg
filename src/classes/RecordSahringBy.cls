public class RecordSahringBy{
   
  
   public static boolean manualShareRead(list<Testsharing__Share > Testsharing,list<User> usr){
   
  /* List<Testsharing__Share > jShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
         RowCause FROM job__share WHERE ParentId = :j.Id AND UserOrGroupId= :user2Id];*/
         
   List<User> users = [SELECT Id,SharingUserId__c FROM User WHERE IsActive = true];

    for(Testsharing__Share newtestsharing: Testsharing){ 
      
     for(User uu:users ){
       
       system.debug('33333333333333333'+newtestsharing.UserOrGroupId);
       
        system.debug('4444444444444444'+uu.id);
     
      if(uu.SharingUserId__c == '12345'){      
         
         
          Testsharing__Share jobShrTestsharing  = new Testsharing__Share();          
          
          system.debug('nnnnnnnnnnnnnnnnn'+newtestsharing.Id);
        
          jobShrTestsharing.ParentId=newtestsharing.ParentId;       
          
           system.debug('user id----------------'+uu.Id);
          
          jobShrTestsharing.UserOrGroupId = uu.Id;
          
          system.debug(' jobShrTestsharing------UserOrGroupId'+ jobShrTestsharing.UserOrGroupId);
          
          jobShrTestsharing.AccessLevel = 'Read';
          
          jobShrTestsharing.RowCause = Schema.Testsharing__Share.RowCause.Manual;
          
          Database.SaveResult sr = Database.insert(jobShrTestsharing,false);
          
          system.debug(' ----------sr --------------'+ sr.Id);
          
          if(sr.isSuccess()){
              return true;
          }
          
          else {
            
             Database.Error err = sr.getErrors()[0];
             
             system.debug('errrrrrrrrrrrrrrrr'+err);
         
             if(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
                      err.getMessage().contains('AccessLevel')){
                      
                 system.debug('else con'+err);
                   return true;
             }
             else{
                 return false;
             
             }
          }
        }   
   }
   
 }
 
 return false;
}

}