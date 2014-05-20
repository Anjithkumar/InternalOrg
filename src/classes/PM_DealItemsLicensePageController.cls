public class PM_DealItemsLicensePageController {
    /*
Description of the class:
Author:satyanarayana
Created:06/02/2013
Modified Date + Things Modified:
1 . 25/3/2013 - Commenting code and reviewing

Code Review results:

*/
    
    String license_DealId=Apexpages.currentPage().getParameters().get('Dealid');
    String license_DealRecordTypeName=Apexpages.currentPage().getParameters().get('RecordTypeName');
    String deal_ObjectId= Schema.SObjectType.Deal__c.getKeyPrefix();
    public List<LicenseWrapper> ListOfLicenses;
    public list<LicenseWrapper> selectedLicenses;
    public List<Deal_Item__c> listOfDealitems=new List<Deal_Item__c>();
    public Deal__c dealValue;
    
    //Constructor querying the Customsetting of type 'License'.
    public PM_DealItemsLicensePageController() {
        
        ListOfLicenses= new List<LicenseWrapper>();
        for(License__c LicenseDetail: [select Id, Name,List_Price__c,Transfer_Price__c from License__c order by List_Price__c asc]) {
            ListOfLicenses.add(new LicenseWrapper(LicenseDetail));
        }
    } 
    
    public Deal__c getDealInstance() {
        //dealValue=new Deal__c ();
        dealValue=[select id,name,Customer__c,Stage__c,Total_Price_Licenses__c,Close_Date__c,CurrencyISOCode,Deal_Start_Date__c,Deal_End_Date__c from Deal__c where id=:license_DealId limit 1];
        return dealValue;
    }
    
    public List<LicenseWrapper> getListOfLicenses() {
        
        return ListOfLicenses;
    } 
    
    //Wrapper class  to display custom settings.
    public class LicenseWrapper{
        Public Boolean selectedValues{get;set;}
        Public String Name {get;set;}
        Public Decimal listPrice{get;set;}
        Public Decimal transferPrice{get;set;}
        public Integer Quantity{get;set;}
        public Decimal salesPrice{get;set;} 
        public String startDate{get;set;}
        public String endDate{get;set;} 
        
        
        public LicenseWrapper(License__c license){
            
            selectedValues=false;
            Name =license.name;
            listPrice=license.List_Price__c;
            transferPrice=license.Transfer_Price__c ;
            Quantity=null;
            salesPrice=null;
            startDate=null;
            endDate=null;
        }
    }
    
    //Saving the Deal lineitems to particular Deal.
    public  pagereference save(){
        selectedLicenses= new List<LicenseWrapper>();
        for(LicenseWrapper LicenseInstance:getListOfLicenses()) {
            
            if(LicenseInstance.selectedValues== true) {
                Deal_Item__c dealItem = new Deal_Item__c();
                dealItem.Deal__c=Apexpages.currentPage().getParameters().get('Dealid');
                dealItem.Product_Edition__c = LicenseInstance.Name ;
                try{
                    dealItem.Quantity__c=LicenseInstance.Quantity;
                    dealItem.Sales_Price__c=LicenseInstance.salesPrice;
                    dealItem.Transfer_Price__c=LicenseInstance.transferPrice;
                }catch(Exception e){
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,e.getMessage());
                    ApexPages.addMessage(myMsg);
                    return null;
                }
                try{
                    dealItem.Start_Date__c=date.parse(LicenseInstance.startDate);
                    dealItem.End_Date__c=date.parse(LicenseInstance.endDate);
                }
                catch(Exception e){
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Date format is invalid or blank');
                    ApexPages.addMessage(myMsg);
                    listOfDealItems.clear();
                    return null;
                }
                if(dealItem.Start_Date__c>dealItem.End_Date__c){
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Start Date should be lessthan End Date');
                    ApexPages.addMessage(myMsg);
                    return null;
                }
                
                dealItem.List_Price__c=LicenseInstance.listPrice;
                RecordType recordTypeName=[select Id,Name from RecordType where SobjectType = 'Deal_Item__c' AND Name=:license_DealRecordTypeName];
                dealItem.RecordTypeId=recordTypeName.id;
                dealItem.CurrencyIsoCode=dealValue.CurrencyIsoCode;
                // inv.CurrencyIsoCode = listOfMilestones[0].Sales_Order__r.CurrencyIsoCode;
                listOfDealItems.add(dealItem);
                
            }
        }
        try{
            
            database.insert(listOfDealitems);
            pagereference pr= new pagereference('/'+ license_DealId);
            return pr;
        }
        catch(Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        
        return null;
    }
    
    public PageReference cancel() {
        pagereference pr= new pagereference('/'+license_DealId);
        return pr;
    }
}