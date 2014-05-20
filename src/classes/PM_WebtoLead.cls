public class PM_WebtoLead {
    /*
Description of the class:
Author:satyanarayana
Created:12/02/2013
Modified Date + Things Modified:
1 . 25/3/2013 -Fixed abug regarding email field, which is unique & Commenting code and reviewing.

Code Review results:

*/
    
    public Customer__c cust;
    
    public PM_WebtoLead(ApexPages.StandardController controller) {
        this.cust= (Customer__c)controller.getRecord();
        cust.Source__c='Web';
        cust.RecordTypeId = [select Id from RecordType where SobjectType ='Customer__c' and Name ='Prospects'].Id;
    }
    
    //Save the record if the email provided by user is unique.
    public pagereference save(){
        
        try{
            insert cust;
            pagereference pr= new pagereference('http://www.extentor.com');
            return pr; 
            
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message (ApexPages.Severity.error,'Your email is already registered with us.'));
        }
        return null;
    }
    
    public pagereference cancel(){
        pagereference pr= new pagereference('http://www.extentor.com');
        return pr;
    }
    
}