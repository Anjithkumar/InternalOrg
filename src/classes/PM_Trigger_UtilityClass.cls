public class PM_Trigger_UtilityClass {
    
    
    final private static List<String> units = new List<String>{'Zero','One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten','Eleven','Twelve','Thirteen','Fourteen','Fifteen','Sixteen','Seventeen','Eighteen','Nineteen'};
        
        final private static List<String> tens =  new List<String>{'','','Twenty','Thirty','Forty','Fifty','Sixty','Seventy','Eighty','Ninety'};
            
            public static Decimal calculateMilestoneRevenue(Id milestoneId){
                Decimal totalMilestoneAmount=0;
                for(Invoice_Line_Item__c ilt:[select Amount__c from Invoice_Line_Item__c where Sales_Order_Item__c=:milestoneId])
                {
                    totalMilestoneAmount=totalMilestoneAmount+ilt.Amount__c;
                }
                return totalMilestoneAmount;
            }
    
    static String convert(Integer i){
        if( i < 20)  return units[i];
        if( i < 100) return tens[i/10] + ((math.mod(i,10) > 0)? ' ' + convert(math.mod(i,10)):'');
        if( i < 1000) return units[i/100] + ' Hundred' + ((math.mod(i,100) > 0)?' and ' + convert(math.mod(i,100)):'');
        if( i < 1000000) return convert(i / 1000) + ' Thousand ' + ((math.mod(i,1000) > 0)? ' ' + convert(math.mod(i,1000)):'') ;
        return convert(i / 1000000) + ' Million ' + ((math.mod(i,1000000)  > 0)? ' ' + convert(math.mod(i,1000000)):'') ;
    }
    
    static String decimalUnits(Integer i){
        if( i < 20)  return units[i];
        return tens[i/10] + ((math.mod(i,10) > 0)? ' ' + convert(math.mod(i,10)):'');  
    }
    
    
    static String convertINR(Integer i){
        if( i < 20)  return units[i];
        if( i < 100) return tens[i/10] + ((math.mod(i,10) > 0)? ' ' + convertINR(math.mod(i,10)):'');
        if( i < 1000) return units[i/100] + ' Hundred' + ((math.mod(i,100) > 0)?' and ' + convertINR(math.mod(i,100)):'');
        if( i < 100000) return convertINR(i / 1000) + ' Thousand ' + ((math.mod(i,1000) > 0)? ' ' + convertINR(math.mod(i,1000)):'') ;
        if(i < 10000000) return convertINR(i / 100000) + ' Lakh ' + ((math.mod(i,100000)  > 0)? ' ' + convertINR(math.mod(i,100000)):'') ;
        return convertINR(i / 10000000) + ' Crore ' + ((math.mod(i,10000000)  > 0)? ' ' + convertINR(math.mod(i,10000000)):'') ;
    }
    
    static String decimalUnitsINR(Integer i){
        if( i < 20)  return units[i];
        return tens[i/10] + ((math.mod(i,10) > 0)? ' ' + convertINR(math.mod(i,10)):'');
        
        
    }
    
    public static String generateText(String invoiceId){
        Decimal totalAmount=0;
        // NumToWords w = new NumToWords();
        Invoice__c currentInvoice = [select Total_Invoice_Amount__c,Amount_In_Words__c,CurrencyIsoCode from Invoice__c where Id = :invoiceId];
        List<Invoice_Line_Item__c> listOfInvoiceLineItems = [select Amount__c,Invoice_LineItem_Tax_Amount__c from Invoice_Line_Item__c where Invoice__c=:currentInvoice.id];
        for(Invoice_Line_Item__c ili:listOfInvoiceLineItems)
        {
            totalAmount=totalAmount+ili.Amount__c+ili.Invoice_LineItem_Tax_Amount__c;
        }
        totalAmount = totalAmount.setScale(2);
        String a = String.valueOf(totalAmount);
        String val = a.substringAfter('.');
        Integer decVal = Integer.valueOf(val);
        Integer i = Integer.valueOf(totalAmount);
        
        if(currentInvoice.CurrencyIsoCode=='INR')
        {
            
            return convertINR(i)+' Rupees And '+decimalUnitsINR(decVal)+' Paise';
        }
        else
        {
            
            return convert(i)+' Dollar And '+decimalUnits(decVal)+ ' Cents';
        }
        
    }
    
    
    
    public static String generateText1(String salesOrderId,Decimal totalAmount){
        Sales_Order__c currentSalesOrder = [select CurrencyIsoCode from Sales_Order__c where Id = :salesOrderId];
        String a = String.valueOf(totalAmount);
        String val = a.substringAfter('.');
        Integer decVal = Integer.valueOf(val);
        Integer i = Integer.valueOf(totalAmount);
        
        if(currentSalesOrder .CurrencyIsoCode=='INR')
        {
            return convertINR(i)+' Rupees And '+decimalUnitsINR(decVal)+' Paise';
        }
        else
        {
            
            return convert(i)+' Dollar And '+decimalUnits(decVal)+ ' Cents';
        }
        
    }
    
    
    
    
}