global class PM_TicketingService implements Messaging.InboundEmailHandler 



{
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          String resultid;
          String emailSubject;
          try
          {
          
          emailSubject=email.subject.substringBetween('#','#');
          Ticket__c ExistingTicket = [Select id ,Ticket_Number__c from Ticket__c where Ticket_Number__c =:emailSubject];
         
          Attachment NewAttachment = new Attachment();
        NewAttachment.name= 'Parent Ticket #'+ExistingTicket.Ticket_Number__c+'#.txt';
        
        NewAttachment.Body= blob.valueOf(email.plainTextBody);
        NewAttachment.Parentid= ExistingTicket.id;
        database.insert(NewAttachment);
          
  List<Attachment> listTextAttachment = new List<Attachment>();
                List<Attachment> listBinaryAttachment = new List<Attachment>(); 
               
                 
                if(email.textAttachments!=null)
                {
                
                   
                    
                    for(Messaging.Inboundemail.TextAttachment attch:email.textAttachments)
                    {
                        Attachment a = new Attachment();
                        a.name=attch.filename;
                        a.body=blob.valueOf(attch.body);
                        a.parentId=ExistingTicket.id;
                        listTextAttachment.add(a);
                    }
                } 
                
                
                if(email.binaryAttachments!=null)
                {
                   
                
                   
                    for(Messaging.Inboundemail.BinaryAttachment bAttach:email.binaryAttachments)
                    {
                        Attachment a = new Attachment();
                        a.name=bAttach.fileName;
                        a.body=bAttach.body;
                        a.parentId=ExistingTicket.id;
                        listBinaryAttachment.add(a);   
                    }
                }
                insert  listTextAttachment;
                insert listBinaryAttachment; 
        
          }
          catch(Exception ex1) 
          {
       
                  Ticket__c NewTicket = new Ticket__c();
                   NewTicket.Email_Content__c= email.plaintextbody;
                   NewTicket.Subject__c=email.subject;
                   NewTicket.Supplied_Email__c=email.fromAddress;
                   NewTicket.Supplied_Name__c=email.fromName;
           try{
           
                   Connection__c SuppliedContact = [select  id, name,Customer__c  from Connection__c where Email__c=:email.fromAddress][0];
                
                   Customer__c SelectedCompany = [Select id,name from Customer__c where id =: SuppliedContact.Customer__c]; 
                   NewTicket.Customer__c=SelectedCompany.id;
                   NewTicket.Connection__c=SuppliedContact.id;
                   Database.saveResult result1 = database.insert(NewTicket );
                    resultid=result1.id;
              }
           catch (Exception ex) 
               {
                       
                      Database.saveResult result2 = database.insert(NewTicket );
                       resultid=result2.id;
                }
        
                      Attachment NewAttachment = new Attachment();
                    NewAttachment.name= 'New Ticket.txt';
                    
                    NewAttachment.Body= blob.valueOf(email.plainTextBody);
                    NewAttachment.Parentid= resultid;
                    database.insert(NewAttachment);
                    
                List<Attachment> listTextAttachment1 = new List<Attachment>();
                List<Attachment> listBinaryAttachment1 = new List<Attachment>(); 
               
                 
                if(email.textAttachments!=null)
                {
              
                   
                    
                    for(Messaging.Inboundemail.TextAttachment attch:email.textAttachments)
                    {
                        Attachment a = new Attachment();
                        a.name=attch.filename;
                        a.body=blob.valueOf(attch.body);
                        a.parentId=resultid;
                        listTextAttachment1.add(a);
                    }
                } 
                
                
                if(email.binaryAttachments!=null)
                {
                   
                   
                   
                    for(Messaging.Inboundemail.BinaryAttachment bAttach:email.binaryAttachments)
                    {
                        Attachment a = new Attachment();
                        a.name=bAttach.fileName;
                        a.body=bAttach.body;
                        a.parentId=resultid;
                        listBinaryAttachment1.add(a);   
                    }
                }
                insert  listTextAttachment1;
                insert listBinaryAttachment1; 
                            
          }
       return result;
      }
  }