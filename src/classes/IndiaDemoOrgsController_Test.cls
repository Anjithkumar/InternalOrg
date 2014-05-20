@isTest(seeAllData=false)
public class IndiaDemoOrgsController_Test{
    private static List<DemoOrgs__c > demoOrgsList;
    static void init(){
    demoOrgsList=new List<DemoOrgs__c>();
        for(integer i=0;i<10;i++){
        	DemoOrgs__c d=new DemoOrgs__c(Name='test'+i,Industry__c='industryTest'+i,User_Name__c='user'+i,Password__c='password'+i);
            demoOrgsList.add(d);
        }
        database.insert(demoOrgsList);
    
    }
    private static testmethod void demoOrgsLoginUnitTest(){
    		init();
        IndiaDemoOrgsController demoOrgsCtrl=new IndiaDemoOrgsController ();
        demoOrgsCtrl.demoOrg=new DemoOrgs__c(Name='Test');
        System.assertEquals(demoOrgsCtrl.saveNewOrg(), null);
        System.assertEquals(demoOrgsCtrl.showNew(),null);
    }
}