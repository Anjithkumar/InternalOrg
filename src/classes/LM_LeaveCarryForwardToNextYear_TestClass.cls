@isTest
private  class  LM_LeaveCarryForwardToNextYear_TestClass
{
    
    private static user newuser;
    //public static LM_CustomSetting__c CreateLeaveAllocation;
    
    public static void init()
    {
        
        newuser =InitializeTestData.createUser('user4@testorg.com');
        database.insert(newuser );
        
        //CreateLeaveAllocation =InitializeTestData.LeaveAllocation();
        //database.insert(CreateLeaveAllocation );
        
        
    }
    static testMethod void BatchableCarryforward()
    {
        LM_CustomSetting__c l1 = new LM_CustomSetting__c(name='testleave', Frequncy_Of_Run__c = '1;4;7;10', No_Of_Annual_Leaves__c=2,No_of_leaves_to_be_carry_forward__c=4 ,Active__c=True);
        insert l1 ;
        
        Test.StartTest();
        
        init();
        
        LM_LeaveCarryForwardToNextYear lm= new LM_LeaveCarryForwardToNextYear ();
        
        //lm.query ='Select id,name, Total_Leave__c from Contact where AccountId =acc.Id AND Exit_Date__C= NULL' ;
        ID batchid = Database.executeBatch(lm);
        Test.StopTest();
        
        //Test.StopTest();
    }
}