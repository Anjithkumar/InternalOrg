@isTest
private class  PM_CreateResourceForecast_TestClass {
    private static Customer__c NewCustomer;
    private static Deal__c NewDeal;
    private static  Resource_Forecast__c NewResource_Forecast;
    private static Services__c testService;
    
    Private static void init()
    {
        NewCustomer = InitializeTestData.createCustomer();
        database.insert(NewCustomer);
        NewDeal=InitializeTestData.createServiceDeal(NewCustomer.id);
        database.insert(NewDeal);
        NewResource_Forecast=InitializeTestData.CreateResource_Forecast(NewDeal.id);
        database.insert(NewResource_Forecast);
        testService=InitializeTestdata.createServices();
        database.insert(testService); 
        
    }
    
    private static testMethod void myUnitTest() {
        init(); 
        
        pagereference pr=new pagereference('/apex/PM_ResourceForecastOnDeal?id='+NewDeal.id);
        Test.setCurrentPageReference(pr);
        Apexpages.StandardController sc = new Apexpages.standardController(NewDeal);
        
        PM_CreateResourceForecast.ServiceWrapper serviceInstance= new PM_CreateResourceForecast.ServiceWrapper(testService);
        PM_CreateResourceForecast services= new PM_CreateResourceForecast ();
        
        services.getDealServiceInstance();
        services.ListOfServices = services.getListOfServices();
        services.ListOfServices[0].selectedValues = true;
        services.selectedValues();
        services.save();
        
        services.cancel();
        
    }
    
}