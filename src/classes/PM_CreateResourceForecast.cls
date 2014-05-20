public class PM_CreateResourceForecast {
    
    // public String countrycode { get; set; }
    String currencyvalue;
    //String slectedvalue{get;set;}
    
    public Deal__c getDealServiceInstance() {
        Deal__c dealValues=[select id,name,Customer__c,Stage__c,Total_Price_Services__c ,Total_Estimated_Hours__c,Close_Date__c,Deal_Start_Date__c,Deal_End_Date__c from Deal__c where id=:Apexpages.currentPage().getParameters().get('id')];
        return dealValues;
    }
    
    
    //String service_DealId=Apexpages.currentPage().getParameters().get('Dealid');
    //String service_DealRecordTypeName=Apexpages.currentPage().getParameters().get('RecordTypeName');
    //String deal_ObjectId= Schema.SObjectType.Deal__c.getKeyPrefix();
    
    public List<ServiceWrapper> ListOfServices;
    public list<ServiceWrapper> selectedServices;
    public List<Resource_Forecast__c> listOfResourceForecasts=new List<Resource_Forecast__c>();
    List<SelectOption> options = new List<SelectOption>();
    public List<CurrencyType> currencyCode;
    public List<ServiceWrapper> getListOfServices() {
        
        return ListOfServices;
    }
    
    
    
    
    public PM_CreateResourceForecast() {
        
        ListOfServices= new List<ServiceWrapper>();
        for(Services__c listOflic: [select Id, Name,Unit_Rate__c from Services__c ORDER BY Name desc]) {
            ListOfServices.add(new ServiceWrapper(listOflic));
        }
        
    } 
    
    public class ServiceWrapper{
        Public Boolean selectedValues{get;set;}
        Public String Name {get;set;}
        public String unitMeasure {get;set;}
        Public Decimal UnitRate{get;set;}
        public Integer Quantity{get;set;}
        public String StartDate{get;set;}
        public String EndDate{get;set;}
        public String countrycode{get;set;}
        
        public ServiceWrapper(Services__c services)
        {
            
            selectedValues=false;
            Name =services.name;
            UnitRate=services.unit_Rate__c;
            Quantity=null;
            unitMeasure=null;
            StartDate=null;
            EndDate=null;
            countrycode=null;
            // salesPrice=0;
        }
    }
    public void selectedValues()
    {
        selectedServices= new List<ServiceWrapper>();
        for(ServiceWrapper services:getListOfServices()) {
            if(services.selectedValues== true) {
                selectedServices.add(services);
                system.debug('-------------------------------------------- INSIDESAVE12');
                system.debug(selectedservices);
            }
        }
        
    }
    
    public List<SelectOption> getlistCurrencyCode() 
    {
        options.clear();
        currencyCode = [select IsoCode,IsActive from CurrencyType where IsActive=true]; 
        if (currencyCode.Size() >0)
        {
            //options.add(new SelectOption('--None--','--None--'));
            for( CurrencyType s:currencyCode)
            {
                if (s.IsoCode != null)
                    
                    options.add(new SelectOption(s.IsoCode,s.IsoCode));
            }
        }
        return options;
    }
    
    
    
    public  pagereference save(){
        try{
            
            selectedValues();
            system.debug('-------------------------------------------- INSIDESAVE');
            //selectedServices= new List<ServiceWrapper>();
            
            
            for(ServiceWrapper serviceInstance:getListOfServices()) {
                
                system.debug('-------------------------------------------- INSIDeForloop');
                if(serviceInstance.selectedValues== true) {
                    //selectedProducts.add(products);
                    system.debug('-------------------------------------------- INSIDEF'+serviceInstance.selectedValues);
                    Resource_Forecast__c ResourceForecast = new Resource_Forecast__c();
                    ResourceForecast .Unit_Rate__c=serviceInstance.UnitRate;
                    ResourceForecast.Deal__c=ApexPages.currentPage().getParameters().get('id');
                    ResourceForecast.Role__c = serviceInstance.Name ;
                    ResourceForecast.Quantity__c=serviceInstance.Quantity;
                    // RecordType recordTypeName=[select Id,Name from RecordType where SobjectType = 'Resource_Forecast__c' AND Name=:service_DealRecordTypeName];
                    //ResourceForecast.RecordTypeId=recordTypeName.id;
                    // try{
                    ResourceForecast.Start_Date__c=Date.parse(serviceInstance.StartDate);
                    ResourceForecast.End_Date__c=Date.parse(serviceInstance.EndDate);
                    /*  }Catch(Exception e) {
ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Date format is invalid or blank');
ApexPages.addMessage(myMsg);
} */
                    
                    ResourceForecast.Unit__c=serviceInstance.unitMeasure;
                    ResourceForecast.CurrencyIsoCode=serviceInstance.countrycode;
                    /* if(ResourceForecast.Start_Date__c!=null&&ResourceForecast.End_Date__c!=null&&){
ResourceForecast.Effort_Days__c=1;
}*/
                    if(ResourceForecast.Start_Date__c!=null&&ResourceForecast.End_Date__c!=null){
                        ResourceForecast.Effort_Days__c=ResourceForecast.Start_Date__c.daysBetween(ResourceForecast.End_Date__c)+1;
                        //ResourceForecast.Percent__c=100;
                        
                    }
                    listOfResourceForecasts.add(ResourceForecast);
                }
            }
            
            
            database.insert(listOfResourceForecasts);
        }catch(Exception e){ 
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            listOfResourceForecasts.clear();
            return null;
        }
        pagereference pr= new pagereference('/'+Apexpages.currentPage().getParameters().get('id'));
        return pr;
    } 
    
    public PageReference cancel() {
        pagereference pr= new pagereference('/'+Apexpages.currentPage().getParameters().get('id'));
        return pr;
    }
    
}