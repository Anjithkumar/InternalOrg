public class PM_PaymentPageController 
{
    private final Payment__c paymentRecord;
    public Boolean chequeDetails{get;set;}
    public Boolean cashDetails{get;set;}
    public Boolean bankTransferDetails{get;set;}
    public PM_PaymentPageController(ApexPages.StandardController controller) 
    {
        this.paymentRecord=(Payment__c)controller.getRecord();
    }
    public PageReference dispSection()
    {
        
        if(paymentRecord.Payment_Mode__c == 'Cheque')
        {
            chequeDetails=true;
            cashDetails=false;
            bankTransferDetails=false;
        }
        else if(paymentRecord.Payment_Mode__c == 'Cash')
        {
            chequeDetails=false;
            bankTransferDetails=false;
            cashDetails=true;
        }
        else if(paymentRecord.Payment_Mode__c == 'Bank Transfer')
        {
            chequeDetails=false;
            cashDetails=false;
            bankTransferDetails=true;
        }
        else 
        {
            chequeDetails=false;
            cashDetails=false;
            bankTransferDetails=false;
        }
        return null;
    }
    
    
}