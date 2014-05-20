public class PM_Resource_Forecast_Edit {
    
    public Resource_Forecast__c resourceForecastInstance {get;set;}
    public Resource_Forecast__c resourceForecast;
    List<SelectOption> options = new List<SelectOption>();
    public List<Services__c> serviceInfo ;
    
    
    
    public PM_Resource_Forecast_Edit(ApexPages.StandardController controller) {
        
        resourceForecast = (Resource_Forecast__c)controller.getRecord();
        resourceForecastInstance =[select name,Effort_Days__c,Percent__c,Start_Date__c,End_Date__c,Deal__c,Quantity__c,role__c,Unit__c,Unit_Rate__c from Resource_Forecast__c where id=:resourceForecast.id] ; 
        
    }
    
    public List<SelectOption> getRole() 
    {
        options.clear();
        serviceInfo = [select name,Unit_Rate__c from Services__c]; 
        if (serviceInfo.Size() >0)
        {
            options.add(new SelectOption('--None--','--None--'));
            for(Services__c s:serviceInfo)
            {
                if (s.name != null)
                    
                    options.add(new SelectOption(s.name,s.name));
            }
        }
        return options;
    }
    public pagereference save(){
        update resourceForecastInstance ;
        pagereference pr= new pagereference('/'+resourceForecastInstance.deal__c);
        return pr;
    }
    
    public pagereference ChangeValue(){
        if(resourceForecastInstance.role__c!='--None--'){
            resourceForecastInstance.Unit_Rate__c=[select name,Unit_Rate__c from Services__c where name=:resourceForecastInstance.role__c].Unit_Rate__c;
        }else
            resourceForecastInstance.Unit_Rate__c=0.0;
        return null;
    } 
}