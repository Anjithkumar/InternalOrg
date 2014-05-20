public class PM_DealItemsServicePageController {
    /*
Description of the class:
Author:satyanarayana
Created:06/02/2013
Modified Date + Things Modified:
1 . 25/3/2013 - Commenting code and reviewing

Code Review results:

*/
    
    public List<ServiceWrapper> ListOfServices;
    public list<ServiceWrapper> selectedServices;
    public List<Deal_Item__c> listOfDealitems=new List<Deal_Item__c>();
    String service_DealId=Apexpages.currentPage().getParameters().get('Dealid');
    String service_DealRecordTypeName=Apexpages.currentPage().getParameters().get('RecordTypeName');
    String deal_ObjectId= Schema.SObjectType.Deal__c.getKeyPrefix();
    
    
    //Constructor querying the Customsetting of type 'Service'.
    public PM_DealItemsServicePageController() {
        
        ListOfServices= new List<ServiceWrapper>();
        for(Services__c listOflic: [select Id, Name,Unit_Rate__c from Services__c]) {
            ListOfServices.add(new ServiceWrapper(listOflic));
        }
    } 
    
    
    public Deal__c getDealServiceInstance() {
        Deal__c dealValues=[select id,name,Customer__c,Stage__c,Total_Price_Services__c ,Total_Estimated_Hours__c,Close_Date__c,Deal_Start_Date__c,Deal_End_Date__c from Deal__c where id=:service_DealId limit 1];
        return dealValues;
    }
    
    
    
    
    public List<ServiceWrapper> getListOfServices() {
        
        return ListOfServices;
    }
    
    //Wrapper class  to display custom settings.
    public class ServiceWrapper{
        Public Boolean selectedValues{get;set;}
        Public String Name {get;set;}
        public String unitMeasure {get;set;}
        Public Decimal UnitRate{get;set;}
        public Integer Quantity{get;set;}
        
        
        public ServiceWrapper(Services__c services){
            selectedValues=false;
            Name =services.name;
            UnitRate=services.unit_Rate__c;
            Quantity=null;
            unitMeasure=null;
        }
    }
    public void selectedValues(){
        selectedServices= new List<ServiceWrapper>();
        for(ServiceWrapper services:getListOfServices()) {
            if(services.selectedValues== true) {
                selectedServices.add(services);
                system.debug(selectedservices);
            }
        }
    }
    
    //Saving the Deal lineitems to particular Deal.
    public  pagereference save(){
        selectedServices= new List<ServiceWrapper>();
        for(ServiceWrapper serviceInstance:getListOfServices()) {
            if(serviceInstance.selectedValues== true) {
                Deal_Item__c dealItem = new Deal_Item__c();
                dealItem .Unit_Rate__c=serviceInstance.UnitRate;
                dealItem.Deal__c=ApexPages.currentPage().getParameters().get('Dealid');
                dealItem.Role__c = serviceInstance.Name ;
                dealItem.Quantity__c=serviceInstance.Quantity;
                RecordType recordTypeName=[select Id,Name from RecordType where SobjectType = 'Deal_Item__c' AND Name=:service_DealRecordTypeName];
                dealItem.RecordTypeId=recordTypeName.id;
                dealItem.Unit__c=serviceInstance.unitMeasure;
                listOfDealItems.add(dealItem);
            }
        }
        try{
            database.insert(listOfDealitems);
        }catch(Exception e){ 
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            return null;
        }
        pagereference pr= new pagereference('/'+service_DealId);
        return pr;
    } 
    
    public PageReference cancel() {
        pagereference pr= new pagereference('/'+ service_DealId);
        return pr;
    }
    
}