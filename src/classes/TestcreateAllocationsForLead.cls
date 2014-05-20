@isTest
private class TestcreateAllocationsForLead {

static testMethod void testSave() {
Project__c project = new Project__c(); 
Test.startTest();
insert project;
List<Allocation__c> all = [Select Id From Allocation__c];
System.assertEquals(1, all.size());
Test.stopTest();
}
}
/*@istest(seealldata=true)
public class testcreateAllocationsForLead {
static testmethod void createAllocationsForLead (){        
    Project__c newPro=new Project__c ();
   // newPro.Project_Lead__c=userinfo.getuserid();
    newPro.Actual_Start_Date__c=date.today();
    newPro.Actual_End_Date__c=date.today();
    newPro.Project_Type__c='internal';
    insert newPro;
    }
 }*/