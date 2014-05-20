trigger RequireComment on Claim__c (before update) {

  // Create a map that stores all the objects that require editing 
  Map<Id, Claim__c> approvalStatements = 
  new Map<Id, Claim__c>{};

  for(Claim__c clam: trigger.new)
  {
    // Put all objects for update that require a comment check in a map,
    // so we only have to use 1 SOQL query to do all checks
    
    if (clam.Approval_Comment_Check__c == 'Requested')
    { 
      approvalStatements.put(clam.Id, clam);
      // Reset the field value to null, 
      // so that the check is not repeated,
      // next time the object is updated
      clam.Approval_Comment_Check__c = null; 
    }
  }  
   
  if (!approvalStatements.isEmpty())  
  {
    // Get the last approval process step for the approval processes, 
    // and check the comments.
    for (ProcessInstance pi : [SELECT TargetObjectId, 
                                (SELECT Id, StepStatus, Comments 
                                 FROM Steps
                                 ORDER BY CreatedDate DESC
                                  LIMIT 1 
                                  )
                               FROM ProcessInstance
                               WHERE TargetObjectId In 
                                    :approvalStatements.keySet()
                               ORDER BY CreatedDate DESC
                              ])
    { 
      // If no comment exists, then prevent the object from saving.                 
      if ((pi.Steps[0].Comments == null || 
           pi.Steps[0].Comments.trim().length() == 0))
      {
        approvalStatements.get(pi.TargetObjectId).addError(
         'Operation Cancelled: Please provide a reason ' + 
         'for your approval / rejection!');
      }
    }  
  }
}