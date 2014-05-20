@isTest(seealldata=false)
private  class PM_Resource_Forecast_Edit_Testclass
{
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static Resource_Forecast__c newresourceforecast;
    private static Services__c newService;
    /*public static Services__c createServices()
{
Services__c newService= new Services__c();
newService.Name='ABCService';
newService.Unit_Rate__c=1500;
return newService;
} */
    
    private static void init(){
        NewCustomer=InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        newresourceforecast=InitializeTestData.CreateResource_Forecast(NewDeal.id);
        newresourceforecast.role__c='ABCService';
        database.insert(newresourceforecast);
        newService=InitializeTestData.createServices();
        database.insert(newService);
        // newService.role__c='developer';
    }
    
    
    private static Testmethod void editSalesOrder(){
        Test.starttest();
        init();
        ApexPages.StandardController sc = new ApexPages.standardController(newresourceforecast);
        PM_Resource_Forecast_Edit pm=new PM_Resource_Forecast_Edit(sc);
        pm.getRole();
        pm.save();
        pm.ChangeValue();
        Test.stoptest();
        
    }
}