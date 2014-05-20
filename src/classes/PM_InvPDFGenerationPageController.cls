public class PM_InvPDFGenerationPageController {
    //Written By Rachit
    public Decimal AmountWithTwoDecimalPlaces{get;set;}
    public Decimal TotalAmountWithTwoDecimalPlaces{get;set;}
    public Boolean invoiceTextRender{get;set;}
    public PM_InvPDFGenerationPageController(ApexPages.StandardController controller) 
    {
        Invoice__c inv = [select Invoice_Text__c from Invoice__c where Id=:ApexPages.currentPage().getParameters().get('id')];
        if(inv.Invoice_Text__c==''||inv.Invoice_Text__c==null)
        {
            invoiceTextRender =false;
        }
        else
        {
            invoiceTextRender = true;
        }
        
    }
    public static Company_Details__c getCompanyDetails()
    {
        Company_Details__c instance = [select Name,Company_Street__c,Company_City__c,Company_State__c,Company_Country__c,Company_Postal_Code__c,Invoice_Payment_Term_1__c,Invoice_Payment_Term_2__c,Invoice_Payment_Term_3__c,Invoice_Payment_Term_4__c,Invoice_Payment_Term_5__c,Sales_Order_Payment_Term_1__c,Sales_Order_Payment_Term_2__c,Sales_Order_Payment_Term_3__c,Sales_Order_Payment_Term_4__c,Sales_Order_Payment_Term_5__c,Beneficiary_A_c_Name__c,Beneficiary_A_c_No__c,Beneficiary_Bank__c,IFSC_Code__c from Company_Details__c where Active__c=true limit 1];
        return instance;
    }   
    public class PDFTaxWrapper
    {
        public Integer Serial{get;set;}
        public String TaxCode{get;set;}
        public Decimal TaxPercent{get;set;}
        public Decimal TaxAmount{get;set;}
    }
    public List<Invoice_Line_Item__c> getInvoiceLineItem()
    {
        Integer i=1;
        List<Invoice_Line_Item__c> var = [select Invoice_Line_Item_Name__c,Unit_Rate__c,Invoice_Quantity__c,Amount__c from Invoice_Line_Item__c where Invoice__c=:ApexPages.currentPage().getParameters().get('id')];
        
        return var;
    }
    
    public List<PDFTaxWrapper> getTaxCode()
    {
        Invoice__c instance = [select Tax_Code__c,Tax_Percent__c,Amount__c,Total_Invoice_Amount__c from Invoice__c where Id=:ApexPages.currentPage().getParameters().get('id')];
        AmountWithTwoDecimalPlaces = instance.Amount__c.divide(1, 2, System.RoundingMode.UP);
        TotalAmountWithTwoDecimalPlaces = instance.Total_Invoice_Amount__c.divide(1, 2, System.RoundingMode.UP);
        List<String> taxCodes = instance.Tax_Code__c.split(';');
        List<String> taxPercentages = instance.Tax_Percent__c.split(';');
        List<PDFTaxWrapper> listofAppliedTaxCodes = new List<PDFTaxWrapper>();
        Integer size = taxCodes.size();
        for(Integer i=0;i<size;i++)
        {
            PDFTaxWrapper AppliedTaxCodes = new PDFTaxWrapper();
            AppliedTaxCodes.Serial = i+1;
            AppliedTaxCodes.TaxCode = taxCodes[i];
            AppliedTaxCodes.TaxPercent = decimal.valueOf(taxPercentages[i]);
            AppliedTaxCodes.TaxAmount = (AppliedTaxCodes.TaxPercent*instance.Amount__c).divide(100, 2, System.RoundingMode.UP);
            listofAppliedTaxCodes.add(AppliedTaxCodes); 
        }
        System.debug(listofAppliedTaxCodes);
        return listofAppliedTaxCodes;
    }
    
    
}