public class PM_ClaimController {

    public static Claim__c claimInstance{get;set;}
    public static User userInstance{get;set;}
    public Integer Serial{get;set;}
    public PM_ClaimController(ApexPages.StandardController controller) 
    {

    }
    public void getDetails()
    {
        claimInstance = [select Id,Total_Amount_to_Claim__c,Name,OwnerId,Claim_Date__c,Project__r.Name,Submitter_Comments__c,Claim_Number__c,CurrencyIsoCode from Claim__c where Id=:ApexPages.currentPage().getParameters().get('id')];
        userInstance = [select Id,Name,EmployeeNumber from User where Id=:claimInstance.OwnerId];
        Serial = 1;
    }
    public List<Claim_Items__c> getClaimItems()
    {
        //System.assertEquals('a','b');
        //System.debug(claimInstance.Id);
        List<Claim_Items__c> liClaimItems= [select Name,Project__r.Name,Id,ExpenseDate__c,Expense_Type__c,Comments__c,Amount_in_Claim_Currency__c,Expense_Amount__c,Exchange_Rate1__c,CurrencyIsoCode,Expense_Currency__c,Exchange_Rate__c,Bill_Number__c from Claim_Items__c where Claim__c=:ApexPages.currentPage().getParameters().get('id')];
        //System.debug(liClaimItems);
        return liClaimItems;
    }

}