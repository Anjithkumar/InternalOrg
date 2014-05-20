global class InitializeTestData{
    
    
    
    //Customer-Prospect Record type
    public static Customer__c  createProspect()
    {
        Customer__c  newConnection = new Customer__c  ();
        newConnection.Name='Extentor solutions pvt Ltd';
        newConnection.First_Name__c= 'Extentor';
        newConnection.Last_Name__c='testing';
        newConnection.Mobile__c='1234567890';
        newConnection.Email__c='abc@xyz.com';
        newConnection.RecordTypeId =[select id,name from recordtype where sobjecttype='Customer__c' and name='Prospects'].id;
        return newConnection ;
    }
    
    //Customer-Company Record type
    public static Customer__c  createCustomer(){
        
        Customer__c newCustomer = new Customer__c();
        newCustomer.Name = 'Extentor';
        newCustomer.First_Name__c= 'Extentor';
        newCustomer.Last_Name__c='testing';
        newCustomer.Mobile__c='1234567890';
        newCustomer.Billing_Street__c='Street';
        newCustomer.Billing_City__c='City';
        newCustomer.Billing_State_Province__c='State';
        newCustomer.Billing_Country__c='Country';
        newCustomer.Shipping_Zip_Postal_Code__c='12345';
        newCustomer.Shipping_Street__c='Street';
        newCustomer.Shipping_City__c='City';
        newCustomer.Shipping_State_Province__c='State';
        newCustomer.Shipping_Country__c='Country';
        newCustomer.Shipping_Zip_Postal_Code__c='12345';
        newCustomer.RecordTypeId =[select id,name from recordtype where sobjecttype='Customer__c' and name='Customer'].id;
        return newCustomer ;
    }
    
    //Supplier 
    public static Customer__c  createSupplier()
    {
        Customer__c newSupplier = new Customer__c();
        newSupplier.Name = 'Test Supplier';
        newSupplier.First_Name__c= 'test';
        newSupplier.Last_Name__c='supplier';
        newSupplier.Mobile__c='1234567890';
        newSupplier.RecordTypeId =[select id,name from recordtype where sobjecttype='Customer__c' and name='Suppliers'].id;
        return newSupplier;
        
    }
    //Connection
    public static Connection__c createConnection(String id)
    {
        Connection__c newConnection = new Connection__c ();
        newConnection .Name='solutions pvt ltd';
        newConnection .First_Name__c='Extentor';
        // newConnection.Last_Name__c='solutions pvt ltd';
        newConnection .Customer__c = id;
        return newConnection ;
    }
    
    //Deal-Service Record type
    public static Deal__c createServiceDeal(String id)
    {
        Deal__c newDeal = new Deal__c ();
        newDeal .Name= 'Extentor';
        newDeal .Customer__c = id;
        newDeal.RecordTypeId =[select id,name from recordtype where sobjecttype='Deal__c' and name='Services'].id;
        newDeal .Close_Date__c=Date.today();
        newDeal .Stage__c='Prospecting';
        newDeal .Deal_Start_Date__c=Date.today();
        newDeal .Total_Estimated_Hours__c=25;
        return newDeal ;
    }
    
    //Deal-License Record type
    public static Deal__c createLicenseDeal(String id)
    {
        Deal__c newDeal = new Deal__c ();
        newDeal .Name= 'Extentor';
        newDeal .Customer__c = id;
        newDeal.RecordTypeId =[select id,name from recordtype where sobjecttype='Deal__c' and name='Licenses'].id;
        newDeal .Close_Date__c=Date.today();
        newDeal .Stage__c='Prospecting';
        newDeal .Deal_Start_Date__c=Date.today();
        newDeal .Total_Estimated_Hours__c=25;
        newDeal.Client_Renewal__c=false;
        return newDeal ;
    }
    //Deal line items- service Record type
    public static Deal_Item__c createServiceDealItem(String dealId)
    {
        Deal_Item__c newDeallineitem = new Deal_Item__c();
        newDeallineitem .Deal__c= dealId;
        newDeallineitem .RecordTypeId =[select developername,name from recordtype where sobjecttype='Deal_Item__c' and Developername='Services'].id;
        newDeallineitem .Role__c='Developer';
        newDeallineitem .Start_Date__c=Date.today();
        newDeallineitem .End_Date__c=Date.today()+2;
        newDeallineitem .Unit__c='Hourly';
        newDeallineitem .Quantity__c=25;
        newDeallineitem .Unit_Rate__c=1500;
        return newDeallineitem ;
    }
    
    //Deal line items- License Record type
    public static Deal_Item__c createLicenseDealItem(String dealId)
    {
        Deal_Item__c newDeallineitem = new Deal_Item__c();
        newDeallineitem .Deal__c= dealId;
        newDeallineitem .RecordTypeId =[select developername,name from recordtype where sobjecttype='Deal_Item__c' and Developername='Licenses'].id;
        newDeallineitem .Product_Edition__c='UE';
        newDeallineitem .Start_Date__c=Date.today();
        newDeallineitem .End_Date__c=Date.today()+2;
        newDeallineitem .Transfer_Price__c=1500;
        newDeallineitem .Sales_Price__c=1600;
        newDeallineitem .Quantity__c=25;
        newDeallineitem .List_Price__c=1800;
        return newDeallineitem ;
    }
    
    //Tax Code-Custom settings
    public static Tax_Code__c createTaxCode()
    {
        Tax_Code__c newTaxCode= new Tax_Code__c ();
        newTaxCode .Name= 'TEST';
        newTaxCode .Tax_Percent__c= 10;
        return newTaxCode ;
    }
    
    //Services-Custom settings
    public static Services__c createServices()
    {
        Services__c newService= new Services__c();
        newService.Name='ABCService';
        newService.Unit_Rate__c=1500;
        return newService;
    }
    
    //Licenses-Custom settings
    public static License__c createLicenses()
    {
        License__c newLicense= new License__c();
        newLicense.name='ABCLicenses';   
        newLicense.List_Price__c=1500;
        newLicense.Transfer_Price__c=1000;
        return newLicense;
    }
    //SalesOrder-Service Record type
    public static Sales_Order__c createServiceSalesOrder(String id)
    {
        Sales_Order__c newSalesOrder= new Sales_Order__c ();
        newSalesOrder.Name='Extentor';
        newSalesOrder.Deal__c=id;
        newSalesOrder.RecordTypeId=[select name,developername from recordtype where sobjecttype='Sales_order__c' and developername ='Service_Type'].id;
        newSalesOrder.Estimated_Revenue__c=1500;
        newSalesOrder.Estimated_Effort__c=45;
        newSalesOrder.Billing_Type__c='FP';
        newSalesOrder.Start_Date__c=Date.today();
        newSalesOrder.Client_Reference_Number__c='EX12345';
        return newSalesOrder;
    }
    //Record Type- Service T&M
    public static Sales_Order__c createServiceSalesOrderTM(String id)
    {
        Sales_Order__c newSalesOrder= new Sales_Order__c ();
        newSalesOrder.Name='Extentor';
        newSalesOrder.Deal__c=id;
        newSalesOrder.RecordTypeId=[select name,developername from recordtype where sobjecttype='Sales_order__c' and developername ='Services_T_M'].id;
        newSalesOrder.Estimated_Revenue__c=1500;
        newSalesOrder.Estimated_Effort__c=45;
        newSalesOrder.Billing_Type__c='T&M';
        newSalesOrder.Start_Date__c=Date.today();
        newSalesOrder.Client_Reference_Number__c='EX12345';
        newSalesOrder.Project_Category__c='Maintainance/Support';
        return newSalesOrder;
    } 
    
    
    //SalesOrder-License Record type
    public static Sales_Order__c createLicenseSalesOrder(String dealid,String accid)
    {
        Sales_Order__c newSalesOrder= new Sales_Order__c ();
        newSalesOrder.Name='Extentor';
        newSalesOrder.Deal__c=dealid;
        newSalesOrder.Customer__c=accid;
        newSalesOrder.RecordTypeId=[select name,developername from recordtype where sobjecttype='Sales_order__c' and developername ='License'].id;
        newSalesOrder.Estimated_Revenue__c=1500;
        newSalesOrder.Estimated_Effort__c=45;
        newSalesOrder.Start_Date__c=Date.today();
        newSalesOrder.Offer_Valid_Through__c=Date.today();
        //newSalesOrder.Address_To__c=accid;
        newSalesOrder.Client_Reference_Number__c='EX12345';
        return newSalesOrder;
    }
    
    //SalesOrder lineItem
    public static Sales_Order_Item__c createServiceSalesOrderItem(String id)
    {
        Sales_Order_Item__c newSalesOrder= new Sales_Order_Item__c();
        newSalesOrder.Name='Extentor';
        newSalesOrder.Sales_Order__c=id;
        /* newSalesOrder.Estimated_Revenue__c=1500;
newSalesOrder.Estimated_Effort__c=45;
newSalesOrder.Start_Date__c=Date.today();
newSalesOrder.Client_Reference_Number__c='EX12345'; */
        return newSalesOrder;
    }
    
    //Consolidated Time sheet
    public static Consolidated_Time_Sheet__c createServiceConsolidatedTimeSheet(String id)
    {
        Consolidated_Time_Sheet__c newSalesOrder= new Consolidated_Time_Sheet__c();
        newSalesOrder.Name='Extentor';
        newSalesOrder.Sales_Order__c=id;
        /* newSalesOrder.Estimated_Revenue__c=1500;
newSalesOrder.Estimated_Effort__c=45;
newSalesOrder.Start_Date__c=Date.today();
newSalesOrder.Client_Reference_Number__c='EX12345'; */
        return newSalesOrder;
    }
    //PROJECT
    public static Project__c createProject(String salesorderid)
    {
        Project__c newProject= new Project__c();
        newProject.Name='Extentor-Product';
        newProject.Project_Code__c='X-00-11-@231-&123';
        newProject.Sales_Order__c=salesorderid;
        newProject.Actual_Revenue__c=10000;
        newProject.Actual_Start_Date__c=Date.today();
        newProject.Actual_End_Date__c=Date.today() +2;
        newProject.Project_Category__c='CB-LAUNCHPAD';
        newProject.Status__c='Open';
        newProject.Project_Type__c='Client Recoverable';
        newProject.Billing_Cycle__c='Monthly';
        return newProject;
    }
    
    
    //Project Task
    public static Project_Task__c createProjectTask(String Projectid)
    {
        Project_Task__c newProjectTask= new Project_Task__c ();
        newProjectTask.Name='Extentor-Product';
        newProjectTask.Project__c=Projectid;
        return newProjectTask;
    }
    
    //Time entry-Read/Write record type
    public static Time_Entry__c createRWTimeEntry(String user_id,String Projectid,String relatedtaskid)
    {
        Time_Entry__c newTimeEntry= new Time_Entry__c();
        newTimeEntry.recordtypeid=[select developername,name from recordtype where sobjecttype='Time_Entry__c' and developername='Read_Write'].id;
        newTimeEntry.Effort_Put_in_by_User__c=user_id;
        newTimeEntry.Project__c=projectid ;
        
        newTimeEntry.Related_Task__c=relatedtaskid;
        newTimeEntry.Effort__c=10;
        return newTimeEntry;
    }
    
    //Time entry-Read/Only record type
    public static Time_Entry__c createReadTimeEntry(String user_id,String Projectid,String relatedtaskid)
    {
        Time_Entry__c newTimeEntry= new Time_Entry__c();
        newTimeEntry.recordtypeid=[select developername,name from recordtype where sobjecttype='Time_Entry__c' and developername='Read_Only'].id;
        newTimeEntry.Effort_Put_in_by_User__c=user_id;
        newTimeEntry.Project__c=projectid ;
        newTimeEntry.Status__c='Approved';
        newTimeEntry.Related_Task__c=relatedtaskid;
        newTimeEntry.Effort__c=10;
        return newTimeEntry;
    }
    
    //ALLOCATION
    public static Allocation__c createAllocation(String projectid,String userid)
    {
        Allocation__c  newAllocation= new Allocation__c ();
        newAllocation.Project__c=projectid;
        newAllocation.Assigned_User__c=userid;
        newAllocation.Start_Date__c=Date.today();
        newAllocation.End_Date__c=Date.today()+2;
        newAllocation.Role__c='Developer';
        return newAllocation;
    }
    
    //Resource Forecast
    public static Resource_Forecast__c  CreateResource_Forecast(string id)
    {
        
        Resource_Forecast__c newResource_Forecast = new Resource_Forecast__c ();
        newResource_Forecast.Deal__c = id;
        newResource_Forecast .Role__c='Developer';
        return newResource_Forecast;
        
    }
    
    //Leave request
    
    public static Leave_Request__c createLeaveRequest(String user_id,Date startDate, Date endDate){ 
        Leave_Request__c testleaverequest = new Leave_Request__c(); 
        testleaverequest.Employee__c=user_id;
        testleaverequest.Project_Lead__c=user_id;
        testleaverequest.Start_Date__c= startDate;
        testleaverequest.End_Date__c= endDate;
        testleaverequest.Reason_for_Leave__c = 'test';
        testleaverequest.Status__c='Applied';
        return testleaverequest;    
    }  
    //User
    public static user createUser(string userName){ 
        string user_id=userinfo.getUserId();
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, Project_Lead__c=user_id, Reports_to_ManagerHR__c=user_id,
                          Type__c ='Internal User',DOB__c=Date.today()+2,TimeZoneSidKey='Asia/Kolkata', UserName=userName,Date_of_Joining__c =Date.today(),Total_Leave__c=21);
        
        
        return u; 
    }
    
    //User-PL
    public static user createPLUser(){ 
        string user_id=userinfo.getUserId();
        //UserRole r = [SELECT Id FROM UserRole WHERE Name='Project Lead'];
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        //testUserpl.EmployeeNumber = '1234234344';
        UserRole r = [SELECT Id FROM UserRole WHERE Name='Project Lead'];
        //testUserpl.UserRoleid = r.id;
        //testUserpl.Email= 'rachitcse0038@gmail.com'; 
        User u = new User(Alias = 'pstandt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, Project_Lead__c=user_id, Reports_to_ManagerHR__c=user_id,
                          Type__c ='Internal User',DOB__c=Date.today()+2,UserRoleId = r.Id, TimeZoneSidKey='Asia/Kolkata', UserName='pltest123@extentor.com',Date_of_Joining__c =Date.today(),Total_Leave__c=21);
        
        
        return u; 
    }
    //User-manager
    public static user createManagerUser(id userid){ 
        string user_id=userinfo.getUserId();  
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, Reports_to_ManagerHR__c=userid,Project_Lead__c=user_id, 
                          TimeZoneSidKey='America/Los_Angeles',Date_of_Joining__c =Date.today(),DOB__c=Date.today()+2
                          ,UserName='test12345@extentor.com',Total_Leave__c=21);
        
        
        return u; 
    }
    //Invoice
    public static Invoice__c  createInvoice()
    {
        Invoice__c newInvoice = new Invoice__c();
        newInvoice.Name = 'TestInvoice';
        newInvoice.CurrencyIsoCode = 'INR';
        return newInvoice ;
    }   
    //Invoice line item
    public static Invoice_Line_Item__c  createInvoiceLineItem(Id invoiceId)
    {
        Invoice_Line_Item__c  newInvoiceLineItem = new Invoice_Line_Item__c();
        newInvoiceLineItem.Invoice__c = invoiceId;
        newInvoiceLineItem.CurrencyIsoCode  = 'INR';
        return newInvoiceLineItem;
    } 
    
    //Custom Setting-Leave Allocation 
    public  static LM_CustomSetting__c LeaveAllocation()
    {
        LM_CustomSetting__c newLeaveAllocation = new LM_CustomSetting__c();
        newLeaveAllocation.name='testleave';
        newLeaveAllocation.No_Of_Annual_Leaves__c = 21;
        newLeaveAllocation.Frequncy_Of_Run__c='1;4;7;10'; 
        newLeaveAllocation.Active__c=True;
        newLeaveAllocation.Year__c='1234';
        return newLeaveAllocation ;
        
    }
    
    
    
    //Leave Request
    public static Leave_Request__c  createLeaveRequest(Id UserId)
    {
        Leave_Request__c  newLeaveRequest = new Leave_Request__c();
        newLeaveRequest.Project_Lead__c = UserId;
        newLeaveRequest.Start_Date__c  = Date.today();
        newLeaveRequest.End_Date__c=Date.today() +2;
        newLeaveRequest.Reason_for_Leave__c='TESTING';
        newLeaveRequest.Status__c='Applied';
        newLeaveRequest.Optional_Holiday__c=False;
        return newLeaveRequest;
    } 
    //Supplier Invoice
    public static Supplier_Invoice__c createSupplierInvoice()
    {
        Supplier_Invoice__c newSupplierInvoice = new Supplier_Invoice__c();
        newSupplierInvoice.Name = 'TestSupplierInvoice';
        return newSupplierInvoice;
    }
    
    //Purchase Order
    public static Purchase_Order__c createPurchaseOrder()
    {
        Purchase_Order__c newPurchaseOrder = new Purchase_Order__c();
        return newPurchaseOrder;
    }
    
    public static Ticket__c createTicket()  
    {
        Ticket__c newTicket = new Ticket__c ();
        
        newTicket.Subject__c='Test Subject';
        newTicket.Priority__c='Low';
        newTicket.Supplied_Email__c='css@gmail.com';
        newTicket.Issue_Type__c='Service Request';
        return newTicket;
        
    }
    
    //SKILL SET
  /*  public static Skill_Set__c createSkillSet()
    {
        Skill_Set__c  newSkill= new Skill_Set__c ();
        newSkill.User__c=userinfo.getuserid();
        newSkill.Skill__c='Soft skill';
        newSkill.Skill_Rating__c='1';
        return newSkill;
    }*/
    //test user for skill set verification
    public static user createManagerUser1(id userid){ 
        string user_id=userinfo.getUserId();  
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standardd', Email='standard2user@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='SkillTesting', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, Reports_to_ManagerHR__c=userid,Project_Lead__c=user_id, 
                          TimeZoneSidKey='America/Los_Angeles',Date_of_Joining__c =Date.today(),
                          UserName='test1234567@extentor.com',Total_Leave__c=21);
        return u; 
    }
    //SKILL SET VERIFICATION
  /*  public static SkillSet_Verification__c createSkillSetVerification(String id){
        SkillSet_Verification__c newSkillVerification= new SkillSet_Verification__c();
        newSkillVerification.Skill_Set__c=id;
        newSkillVerification.Rating_By_Verfier__c='2';
        newSkillVerification.User__c=userinfo.getuserid();
        return newSkillVerification;
        
    }*/
  //Claim   
    public static Claim__c createClaim (id userid){
     Claim__c createClaim = new Claim__c();
     createClaim.name ='Test claim';
     createClaim.Approval_Comment_Check__c= 'Requested';
     createClaim.Claim_Status__c='Submitted';
     createClaim.Approving_Manager__c=userid;
     createClaim.Submitter_Comments__c='testing';
     createClaim.Claim_Date__c=system.today();
     return createClaim ;
    
    }
   
   //Claim items 
    public static Claim_Items__c createClaimitems(string claimid){
    Claim_Items__c newclaimitems = new Claim_Items__c();
    newclaimitems.name='testclaimtest';
    newclaimitems.Claim__c =claimid;
    newclaimitems.ExpenseDate__c=system.today();
    newclaimitems.Amount_in_Claim_Currency__c=200;
    newclaimitems.Expense_Amount__c=12000;
    newclaimitems.Expense_Currency__c='AUD';
      newclaimitems.Expense_Type__c='Accommodation';
    return newclaimitems;
  }  
}