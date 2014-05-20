@isTest
private  class  LM_CustomSetting_TestClass
{
    static testMethod void CustomSetting()
        
    {
        LM_CustomSetting__c l1 = new LM_CustomSetting__c(name='testleave', Frequncy_Of_Run__c = '1;4;7;10',Frequency_Text__c='123', No_Of_Annual_Leaves__c=2,No_of_leaves_to_be_carry_forward__c=4 ,Active__c=True,Year__c='1190');
        insert l1 ;
        
        pagereference pr=new pagereference('/apex/LM_CustomSetting');
        Test.setCurrentPageReference(pr);
        Apexpages.StandardController sc = new Apexpages.standardController(l1);
        
        
        
        LM_CustomSetting  LeaveAllocation = new LM_CustomSetting(sc);
        LeaveAllocation.getFrequecny();
        LeaveAllocation.add();
        LeaveAllocation.customEdit();
        LeaveAllocation.currentRecord();
        LeaveAllocation.previousRecord();
        LeaveAllocation.Cancel();
        LeaveAllocation.save();
    }
}