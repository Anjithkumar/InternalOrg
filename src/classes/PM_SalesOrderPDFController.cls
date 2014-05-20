public class PM_SalesOrderPDFController {
    
    
    public Sales_Order__c salesOrder{get;set;}
    public Decimal totalTaxCode{get;set;}
    public Decimal totalAmount{get;set;}
    public String termsAndConditions{get;set;}
    public Decimal subtotalAmount{get;set;}
    public String AmountInWords{get;set;}
    
    public PM_SalesOrderPDFController(ApexPages.StandardController controller) 
    {
        
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
    
    public List<Deal_Item__c> getDealItems()
    {
        
        salesOrder = [select Customer__c,Deal__c,Deal__r.Total_Price_Licenses__c,Tax_Code__c,Tax_Percent__c from Sales_Order__c where Id=:ApexPages.currentPage().getParameters().get('id') limit 1];
        //Document d = [select Id,Body from Document where Document.Name='Terms & Conditions'];
        List<Deal_Item__c> var = [select Id,Product_Edition__c,List_Price__c,Sales_Price__c,Quantity__c,Total_Price_Licenses__c from Deal_Item__c where Deal__c=:salesOrder.Deal__c];
        totalAmount = salesOrder.Deal__r.Total_Price_Licenses__c; 
        subtotalAmount = salesOrder.Deal__r.Total_Price_Licenses__c;
        return var;
    }
    
    public List<PDFTaxWrapper> getTaxCode()
    {
        List<String> taxCodes = salesOrder.Tax_Code__c.split(';');
        List<String> taxPercentages = salesOrder.Tax_Percent__c.split(';');
        List<PDFTaxWrapper> listofAppliedTaxCodes = new List<PDFTaxWrapper>();
        Integer size = taxCodes.size();
        totalTaxCode=0;
        for(Integer i=0;i<size;i++)
        {
            PDFTaxWrapper AppliedTaxCodes = new PDFTaxWrapper();
            AppliedTaxCodes.Serial = i+1;
            AppliedTaxCodes.TaxCode = taxCodes[i];
            AppliedTaxCodes.TaxPercent = decimal.valueOf(taxPercentages[i]);
            AppliedTaxCodes.TaxAmount = (AppliedTaxCodes.TaxPercent*salesOrder.Deal__r.Total_Price_Licenses__c).divide(100, 2, System.RoundingMode.UP);
            totalTaxCode = totalTaxCode+AppliedTaxCodes.TaxAmount;
            listofAppliedTaxCodes.add(AppliedTaxCodes); 
        }
        totalAmount=totalAmount+totalTaxCode;
        AmountInWords=PM_Trigger_UtilityClass.generateText1(ApexPages.currentPage().getParameters().get('id'),totalAmount);
        System.debug(listofAppliedTaxCodes);
        return listofAppliedTaxCodes;
    }
    
    public List<Terms_And_Conditions__c> getTermConditions()
    {
        List<Terms_And_Conditions__c> listoftermsconditions = [select Name,Text__c from Terms_And_Conditions__c order by Name];
        return listoftermsconditions ;
    }
}