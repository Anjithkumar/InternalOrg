global class PM_Convert_Prospects_To_Customers{
/*
Description of the class:
Author:satyanarayana
Created:04/02/2013
Modified Date + Things Modified:
1 . 22/3/2013 - Commenting code and reviewing
2.Bug:24/07/2013- Narayana-Commented 118,119 line and added Date.today() in 120th line;Reason behind :In 118th line taking the Prospect created date

Code Review results:

*/
    public String dealServiceName { get; set; }    
    public String dealLicenseName { get; set; }
    public Boolean displayDeals { get; set; }
    public Boolean createDeals { get; set; }
    public Boolean createServiceOpp { get; set; }
    public Boolean createLicenseOpp { get; set; }
    public String customerId {get;set;}
    public Customer__c instance {get;set;}
    String objectId = Schema.SObjectType.Customer__c.getKeyPrefix();
    
    // to render it appropriately on page
    public PageReference hideDealTable() {
        displayDeals  = false;
        return null;
    }
    
    //to display the section when check box is checked.
    public PageReference showDealTable() {
        displayDeals  = true;
        return null;
    }
    
        
    public PageReference cancel() {
        pageReference pr=new PageReference('/'+customerId);
        return pr;
    }
    
    public PM_Convert_Prospects_To_Customers(){
        customerId  = Apexpages.Currentpage().getParameters().get('id');
        instance = [select id,RecordTypeId,Name,First_Name__c,Last_Name__c,Phone__c,Mobile__C,Email__c,Billing_Street__c,Billing_City__c,Billing_State_Province__c,Billing_Zip_Postal_Code__c,Billing_Country__c,Description__c,CreatedDate  from Customer__c where Id=:Apexpages.Currentpage().getParameters().get('id')];
        dealServiceName =instance.Name +'-';
        dealLicenseName =instance.Name +'-';
    }
       
    
    public pagereference Save() {
        Convert();
        if(createServiceOpp==true){
            convertServiceOpp();
        }
        if(createLicenseOpp==true){
            convertLicenseOpp();
        }
        pagereference pr=new pagereference('/'+ instance.id);
        return pr ;
    }
    
    
    //WebService static String Convert(String customerId) 
    public String Convert()
    {  
        // changing record type from prospect to customer
        RecordType recordId = [select Id,Name from RecordType where SobjectType = 'Customer__c' and Name = 'Customer'];
        instance.RecordTypeId = recordId.Id;
        update instance;
        
        //creating a connection with appropriate fields
        Connection__c customerConnection = new Connection__c();
        if(instance.First_Name__c!=null)
        {
            customerConnection.Name = instance.First_Name__c+' '+instance.Last_Name__c;
            customerConnection.First_Name__c = instance.First_Name__c;
        }
        else
        {
            customerConnection.Name = instance.Last_Name__c;
        }
        customerConnection.Name= instance.Last_Name__c;
        customerConnection.Customer__c=instance.id;
        customerConnection.Phone__c= instance.Phone__c;
        customerConnection.Mobile__c=instance.Mobile__c;
        customerConnection.Email__c= instance.Email__c;
        customerConnection.Street__c= instance.Billing_Street__c;
        customerConnection.City__c=instance.Billing_City__c;
        customerConnection.State_Province__c= instance.Billing_State_Province__c;
        customerConnection.Zip_Postal_Code__c= instance.Billing_Zip_Postal_Code__c;
        customerConnection.Country__c = instance.Billing_Country__c;
        customerConnection.Description__c=instance.Description__c;
        try{
            insert customerConnection;
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return null;
    }
    
    // creating a new opportunity of type 'service' if checked on VF page
    public void convertServiceOpp(){
        Deal__c customOpportunityService=new Deal__c();
        RecordType ServiceId= [select Id,Name from RecordType where SobjectType = 'Deal__c' and Name ='Services'];
        customOpportunityService.RecordTypeId=ServiceId.id;
        customOpportunityService.name=dealServiceName ;
        customOpportunityService.Customer__c=instance.id;
        insert customOpportunityService;
    }
    // creating a new opportunity of type 'license' if checked on VF page
    public void convertLicenseOpp(){
        Deal__c customOpportunityLicense=new Deal__c();
        RecordType LicenseId= [select Id,Name from RecordType where SobjectType = 'Deal__c' and Name ='Licenses'];
        customOpportunityLicense.RecordTypeId=LicenseId.id;
        customOpportunityLicense.name=dealLicenseName ;
        customOpportunityLicense.Customer__c=instance.id;
       // DateTime dT = instance.CreatedDate;
       // Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
        customOpportunityLicense.Close_Date__c=(Date.today()).addDays(30);
        insert customOpportunityLicense;
        
    }
    
}