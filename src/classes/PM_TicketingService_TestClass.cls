@isTest(SeeAllData=false)
private class PM_TicketingService_TestClass
{
private static Customer__c  newCustomer;
private static Connection__c  newConnection;
 private static Ticket__c newTicket;
//private static Attachment newAttachment;
 
 private static void init(){



NewCustomer = InitializeTestData.createCustomer();
     database.insert(NewCustomer);
   newConnection=InitializeTestData.createConnection(NewCustomer.id);  
     database.insert(newConnection);
     newTicket =InitializeTestData.createTicket();
       newTicket.Customer__c=NewCustomer.id;
       newTicket.Connection__c=newConnection.id;
       database.insert(newTicket);
   
     
     }

static testMethod void PM_TicketingService() {
 
  // create a new email and envelope object
  Messaging.InboundEmail email = new Messaging.InboundEmail() ;
  Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
 
 Messaging.InboundEmail email1 = new Messaging.InboundEmail();
  Messaging.InboundEnvelope env1 = new Messaging.InboundEnvelope();
  // setup the data for the email
  email.subject = 'Test Job Applicant';
  email.fromname = 'FirstName';
  email.plaintextbody='Email test Body ';
  env.fromAddress = 'someaddress@email.com';
  
   Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
  attachment.body = blob.valueOf('my attachment text');
  attachment.fileName = 'textfile.txt';
  attachment.mimeTypeSubType = 'text/plain';
 
  email.binaryAttachments =
    new Messaging.inboundEmail.BinaryAttachment[] { attachment };
  
  
  Messaging.InboundEmail.TextAttachment attachmentText = new Messaging.InboundEmail.TextAttachment();
  attachmentText.body = 'my attachment text';
  attachmentText.fileName = 'textfile.txt';
  attachmentText.mimeTypeSubType = 'text/plain';
 
  email.textAttachments=
    new Messaging.inboundEmail.TextAttachment[] { attachmentText };
  
  init();
  
  
  
  
  Test.startTest();
  PM_TicketingService  emailProcess = new PM_TicketingService ();
  emailProcess.handleInboundEmail(email, env);
  
 
  Ticket__c createdTicket = [ Select id,Ticket_Number__c from Ticket__c where id =: newTicket.id ];
  
 
  system.assertNotEquals(createdTicket ,null);
  email1.subject = 'Parent Ticket #'+createdTicket.Ticket_Number__c+'#';
  email1.fromname = 'FirstName';
  email1.plaintextbody='Email test Body ';
  env1.fromAddress = 'someaddress@email.com';
   
   Messaging.InboundEmail.BinaryAttachment attachment1 = new Messaging.InboundEmail.BinaryAttachment();
  attachment1.body = blob.valueOf('my attachment text');
  attachment1.fileName = 'textfile.txt';
  attachment1.mimeTypeSubType = 'text/plain';
 
  email1.binaryAttachments =
    new Messaging.inboundEmail.BinaryAttachment[] { attachment1 };
  
  Messaging.InboundEmail.TextAttachment attachmentText1 = new Messaging.InboundEmail.TextAttachment();
  attachmentText1.body = 'my attachment text';
  attachmentText1.fileName = 'textfile.txt';
  attachmentText1.mimeTypeSubType = 'text/plain';
 
  email1.textAttachments=
    new Messaging.inboundEmail.TextAttachment[] { attachmentText1 };
  
  
  
  
  
 emailProcess.handleInboundEmail(email1, env1);
  
 
 

  Test.stopTest();
  
  }
  }