trigger LM_SubmitforApproval on Leave_Request__c (after insert) {
    
    // create the new approval request to submit
    for(Leave_Request__c leave:trigger.new)
    {
    if( leave.Override_Validation__c!=true)
    {
        // create the new approval request to submit
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitted for approval. Please approve.');
        req.setObjectId(leave.Id);
       
        
        // submit the approval request for processing
        Approval.ProcessResult result = Approval.Process(req);
        result.getEntityId();
        
        // display if the reqeust was successful
        System.debug('Submitted for approval successfully: '+result.isSuccess());
    
    }
    }
}