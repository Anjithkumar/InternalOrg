trigger approvelbymanager on Claim__c (after insert) {

        if(trigger.isInsert) 
        {
          // Create an list of sharing object for Claim
             List<Claim__share> approve= new List<Claim__share>();
         
          //Decalring a variable for approval manager on sharing
         
             Claim__share Approvalmngr;
             
             for(Claim__c claim : trigger.new) {
             
             
              Approvalmngr =new Claim__share();
              
              // Set the ID of record being shared
              
              Approvalmngr.ParentId = claim.Id;
              
                // Set the ID of user or group being granted access
                
              Approvalmngr.UserOrGroupId = claim.Approving_Manager__c;
              
               // Set the access level
               
              Approvalmngr.AccessLevel = 'read';
              
               
            // Set the Apex sharing reason for hiring manager and recruiter
             //  Approvalmngr.RowCause = Schema.Claim__share.RowCause.Approving_Manager__c;
             
               // Add objects to list for insert
                 
               approve.add(Approvalmngr);
               
             
             }
        
                  Database.SaveResult[] lsr = Database.insert(approve,false);
                  Integer i=0;
                   for(Database.SaveResult sr : lsr) {
                   
                   if(!sr.isSuccess()) {
                   
                    Database.Error err = sr.getErrors()[0];
                    
                     if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                               &&  err.getMessage().contains('AccessLevel'))){
                    // Throw an error when the error is not related to trivial access level.
                    trigger.newMap.get(approve[i].ParentId).
                    addError('Unable to grant sharing access due to following exception: '+ err.getMessage());
                }
                }
                i++;
              }
                          
        
        }

}