public class PM_TaxCode {
    /*
Description of the class:
Author:satyanarayana
Created:24/01/2013
Modified Date + Things Modified:
1 . 25/3/2013 - Commenting code and reviewing

Code Review results:

*/
    
    List<TaxCodeWrapper> ListOfTaxWrapper;
    public list<TaxCodeWrapper> selectedTaxes;
    public Sales_Order__c salesRecord{get;set;}
    public sales_Order__c currentSalesOrder;
    String salesOrderId=apexpages.currentpage().getparameters().get('id');
    string st='';
    string sp='';
    
    public PM_TaxCode(ApexPages.StandardController con) {
        this.salesRecord= (Sales_Order__c)con.getrecord();
        ListOfTaxWrapper= new List<TaxCodeWrapper>();
        currentSalesOrder=[select id, name,Tax_Percent__c,Tax_Code__c from sales_Order__c where id=:salesOrderId];
        Set<String> selectedTaxCodes = new Set<String>();
        if(currentSalesOrder.Tax_Code__c != null){
            selectedTaxCodes.addAll(currentSalesOrder.Tax_Code__c.split(';'));
        }
        for(Tax_Code__c TaxDetail: [select Id, Name,Tax_Percent__c from Tax_Code__c]) {
            if(selectedTaxCodes.contains(TaxDetail.Name)){
                ListOfTaxWrapper.add(new TaxCodeWrapper(TaxDetail,true));
            }
            else{
                ListOfTaxWrapper.add(new TaxCodeWrapper(TaxDetail,false));
            }
            
        }
        
    } 
    
    
    public List<TaxCodeWrapper> getListOfTaxes() {
        
        return ListOfTaxWrapper;
    } 
    // Wrapper class to display cutom setting values like taxcode and taxpercent.
    public class TaxCodeWrapper{
        Public Boolean selectedValues{get;set;}
        Public String Name {get;set;}
        public Decimal Percentage{get;set;}
        public sales_Order__c salesrecords;
        
        public TaxCodeWrapper(Tax_Code__c taxcode, Boolean val){
            Name =taxcode.name;
            Percentage=taxcode.Tax_Percent__c;
            selectedValues=val;  
        }
    }
    
    //Save the tax code and tax percent values to the related salesorder.
    public  pagereference save(){
        sales_order__c salesorder= new sales_order__c();
        selectedTaxes= new List<TaxCodeWrapper>();
        for(TaxCodeWrapper TaxInstance:getListOfTaxes()) {
            
            if(TaxInstance.selectedValues== true) {
                selectedTaxes.add(TaxInstance);
            }
        }
        
        for(Integer i=0;i<selectedTaxes.size();i++){
            st+= selectedTaxes[i].name+';'; 
            sp+=selectedTaxes[i].Percentage+';';
        }
        if(st.length()==0){
            salesRecord.Tax_Code__c= '';
            salesRecord.Tax_Percent__c='';  
        }
        else{
            salesRecord.Tax_Code__c=st.substring(0,st.length()-1);
            salesRecord.Tax_Percent__c=sp.substring(0,sp.length()-1);
        }
        Database.update(salesRecord);
        pageReference pr= new pageReference('/'+salesOrderId);
        return pr;
    }
}