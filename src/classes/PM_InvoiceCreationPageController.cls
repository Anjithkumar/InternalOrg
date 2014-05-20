public class PM_InvoiceCreationPageController {
    
    public String selectedTaxCode{get;set;}
    public String selectedTab{get;set;}
    public String valueToRemove{get;set;}
    public Boolean AddInvLineItemSection{get;set;}
    public Boolean AddInvLineItemButton{get;set;}
    public Boolean AddInvLineItemLink{get;set;}
    public List<Consolidated_Time_Sheet__c> tempListOfMilestones;
    public Sales_Order__c salesorders {get;set;}
    public List<Consolidated_Time_Sheet__c> finalListOfMilestones {get;set;}
    public Invoice__c inv;
    public List<Invoice_Line_Item__c> listofnewinvoicelineItems = new List<Invoice_Line_Item__c>();
    public Invoice_Line_Item__c newinvoicelineItems;
    public String selectedValue{get;set;}
    public Boolean step2{get;set;}
    public Boolean step3{get;set;}
    List<TaxCodeWrapper> listOfTaxCodeWrappers;
    
    public List<TaxCodeWrapper> getListOfTaxCodeWrappers(){
        
        return listOfTaxCodeWrappers;
        
    }
    
    ApexPages.StandardSetController setCon;
    
    public PM_InvoiceCreationPageController(ApexPages.StandardSetController controller) 
    {
        setCon = controller;
        AddInvLineItemButton=true;
        salesorders=[select name from Sales_Order__c where id=:ApexPages.currentPage().getParameters().get('Id')];
        finalListOfMilestones = new List<Consolidated_Time_Sheet__c>();
        Set<Id> milestoneIds = new Set<Id>();
        String consolidatedIds=ApexPages.currentPage().getParameters().get('rec');
        
        
        
        for( Consolidated_Time_Sheet__c queriedMilestone : [select Id,Name,Planned_Date__c,Sales_Order__r.id,Status__c,Actual_Milestone_Revenue__c,Actual_Date__c,Planned_Milestone_Revenue__c,Sales_Order__r.Customer__c,Sales_Order__r.Customer__r.Name,Sales_Order__r.Tax_Percent__c,Sales_Order__r.Tax_Code__c,Sales_Order__r.Name,Quantity__c,unit_rate__c,Milestone_Reference_Number__c,Billing_type__c,Sales_Order__r.Client_Reference_Number__c from Consolidated_Time_Sheet__c where Id IN : consolidatedIds.split(';') AND (Status__c='Completed' OR Status__c='Partially Invoiced')]){
            finalListOfMilestones.add(queriedMilestone);
            segregateTaxCodes(queriedMilestone);
        }
    } 
    
    public class TaxCodeWrapper
    {        
        public String taxcode {get;set;}
        public String taxpercent {get;set;} 
    }
    
    public void segregateTaxCodes(Consolidated_Time_Sheet__c ms)
    {
        listOfTaxCodeWrappers = new List<TaxCodeWrapper>();
        List<String> taxCodes = ms.Sales_Order__r.Tax_Code__c.split(';');
        List<String> taxPercentages = ms.Sales_Order__r.Tax_Percent__c.split(';');
        for(Integer i=0; i < taxCodes.size(); i++){
            TaxCodeWrapper instance = new TaxCodeWrapper();
            instance.taxCode = taxCodes[i];
            instance.taxPercent = taxPercentages[i];
            listOfTaxCodeWrappers.add(instance);
            
        }
    }
    
    public List<SelectOption> getItems()
    {
        List<SelectOption> options = new List<SelectOption>();       
        for(Tax_Code__c tc: [select Name,Tax_Percent__c from Tax_Code__c])
        {
            options.add(new SelectOption(tc.Name+ ';' + tc.Tax_Percent__c.format(),tc.Name )) ;
        }
        return options;
    }
    
    public Invoice__c getInvoiceDetails()
    {
        inv = new Invoice__c();
        return inv;
    }
    
    public List<Invoice_Line_Item__c> getAdditionalLineItems(){
        
        
        return listofnewinvoicelineItems;
    }
    
    
    
    public Invoice_Line_Item__c getNewInvoiceLineItems(){  
        
        
        
        return newinvoicelineItems ;
    }
    
    
    
    public PageReference Remove()
    {
        tempListOfMilestones = new List<Consolidated_Time_Sheet__c>();
        valueToRemove=ApexPages.currentPage().getParameters().get('removeRow');
        
        List<Consolidated_Time_Sheet__c> tempList = new List<Consolidated_Time_Sheet__c>();
        for(Consolidated_Time_Sheet__c tempVariable :finalListOfMilestones){
            if(tempVariable.Id != valueToRemove){
                tempListOfMilestones.add(tempVariable);
            }
        } 
        finalListOfMilestones = tempListOfMilestones;
        
        return null;
    } 
    
    public PageReference AddToInvoice()
    {
        AddInvLineItemLink=true;
        
        listofnewinvoicelineItems.add(newinvoicelineItems );
        newinvoicelineItems = new Invoice_Line_Item__c();
        
        return null;
    }
    
    public PageReference goToStep2(){step2=true;selectedTab='name2';newinvoicelineItems = new Invoice_Line_Item__c();return null;}
    public PageReference goToStep3(){step3=true;selectedTab='name3';return null;}
    public PageReference goFromStep2ToStep3(){step3=true;selectedTab='name3';return null;}
    public PageReference Save()
    {
        List<Consolidated_Time_Sheet__c> listOfMilestones = finalListOfMilestones;
        Integer isValid=0;
        Boolean check=false;
        Integer listSize = listOfMilestones.size();
        String checkAccount = null;
        String checkBillingType = null;
        for(Consolidated_Time_Sheet__c currentMilestone:listOfMilestones)
        {
            if((currentMilestone.Status__c=='Completed'||currentMilestone.Status__c=='Partially Invoiced')&&(checkAccount==null||currentMilestone.Sales_Order__r.Customer__c==checkAccount)&&(checkBillingType==null||currentMilestone.Billing_Type__c==checkBillingType))
            {
                if(checkAccount==null)
                {
                    checkAccount = currentMilestone.Sales_Order__r.Customer__c;
                }
                if(checkBillingType==null)
                {
                    checkBillingType = currentMilestone.Billing_Type__c;
                }
                
                isValid=isValid+1;
                
                system.debug('in here');
            }
            
        }
        if(isValid==listSize){
            
            
            inv.Sales_Order__c=listOfMilestones[0].Sales_Order__r.id;        
            inv.Tax_Code__c =finalListOfMilestones [0].Sales_Order__r.Tax_Code__c;
            String taxPercents ='';
            for(integer i=0;i<listOfTaxCodeWrappers.size();i++){
                taxPercents= taxPercents + listOfTaxCodeWrappers[i].taxpercent + ';';
                
            }
            inv.Tax_Percent__c=taxPercents.substring(0,taxPercents.length()-1);
            
            for(integer i=0;i<finalListOfMilestones.size();i++){
                
            }
            insert inv;
            List<Invoice_Line_Item__c> listOfInvoiceLineItem = new List<Invoice_Line_Item__c>();
            for(Consolidated_Time_Sheet__c currentMilestone:listOfMilestones)
            {
                Invoice_Line_Item__c instance = new Invoice_Line_Item__c();
                instance.Invoice__c = inv.id;
                instance.Consolidated_Time_Sheet__c = currentMilestone.id;
                instance.Invoice_Line_Item_Name__c=currentMilestone.Sales_Order__r.Name+'-'+Date.today().format();
                instance.Invoice_Quantity__c=currentMilestone.Quantity__c;
                instance.Unit_Rate__c=currentMilestone.Unit_Rate__c;
                listOfInvoiceLineItem.add(instance);
                
            }
            for(Invoice_Line_Item__c currentInvLineItem:listofnewinvoicelineItems)
            {
                currentInvLineItem.Invoice__c=inv.id;
                listOfInvoiceLineItem.add(currentInvLineItem);                 
            }
            database.insert(listOfInvoiceLineItem);
            PageReference pg = new PageReference('/'+inv.Id);
            return pg;
        }
        else
        {
            ApexPages.Message myMsg=new ApexPages.Message(ApexPages.Severity.Error, 'Milestone Status should be completed or partially invoiced.||Milestone Should Belong to Same Account.||Milestone Billing Type Should be same.');
            ApexPages.addMessage(myMsg);
        }
        
        return null;   
    }
    
    public pageReference removeLink(){
        selectedValue=ApexPages.currentPage().getParameters().get('removeRow');
        Integer i= Integer.valueOf(selectedValue);
        listofnewinvoicelineItems.remove(i-1);
        return null;
    }
}