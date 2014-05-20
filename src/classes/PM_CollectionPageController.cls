public class PM_CollectionPageController {
    private final Receipt__c collectionRecord;
    public PM_CollectionPageController(ApexPages.StandardController controller) 
    {
        this.collectionRecord=(Receipt__c)controller.getRecord();
    }
    public Boolean chequeDetails{get;set;}
    public Boolean cashDetails{get;set;}
    public Boolean bankTransferDetails{get;set;}
    
    public Pagereference dispFields()
    {
        if(collectionRecord.Payment_Mode__c=='Cheque')
        {
            chequeDetails=true;
            cashDetails=false;
            bankTransferDetails=false;
        }
        else if(collectionRecord.Payment_Mode__c=='Cash')
        {
            chequeDetails=false;
            bankTransferDetails=false;
            cashDetails=true;
        }
        else if(collectionRecord.Payment_Mode__c=='Bank Transfer')
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