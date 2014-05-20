public class PM_ScopeController {
    public  Project__c proj;
    public Project__c nameOfProject {get;set;} 
    List<Scope__c> existingListOfScope = new List<Scope__c>();
    List<Scope__c> newScopeList = new List<Scope__c>();
    
    public List<Scope__c> getlistOfScope(){
        return newScopeList;
    }
    public String selectedValue{get;set;}
    public string selectedValues{get;set;}
    
    public PM_ScopeController(ApexPages.StandardController controller) {
        this.proj= (Project__c )controller.getRecord();
        existingListOfScope = [select Id,Name,Related_Project__c,Related_Project__r.Name,Description__c from Scope__c where Related_Project__c=:proj.id order by Name];
        newScopeList.addAll(existingListOfScope);
        nameOfProject=[select name from Project__c  where id=:proj.id limit 1];
        if(existingListOfScope.size()==0){
         addNewScope();
        }
    }
    
    public PageReference addNewScope() 
    {
        Scope__c  newInstance = new Scope__c();
        newInstance.Related_Project__c=proj.id;
        newScopeList.add(newInstance);
        return null;
        
    }
    public PageReference remove() {
        Integer i=existingListOfScope.size();
        
        selectedValue=ApexPages.currentPage().getParameters().get('deleteRow');
        system.debug(selectedValue);
        if(selectedValue!=null && selectedValue!= ''){
            Scope__c deleteInstance = new Scope__c(Id=selectedValue);
            
            selectedValues=ApexPages.currentPage().getParameters().get('removeRow');
            integer x=integer.valueof(selectedValues);
            newScopeList.remove(x-1);
            delete deleteInstance;
            
        }else{
            selectedValues=ApexPages.currentPage().getParameters().get('removeRow');
            system.debug(selectedValues);
            integer x=integer.valueof(selectedValues);
            newScopeList.remove(x-1);
        }
        return null;
    }
    
    public pageReference save(){
        Integer i= newScopeList.size();
        List<Scope__c > listToUpsert = new List<Scope__c>();
        for(Integer j = 0; j < i; j++){
            if(newScopeList[j].Description__c != null){
                listToUpsert.add(newScopeList[j]);
            }
        }
        if(listToUpsert.size()>0){
            upsert listToUpsert;
           }
        pageReference pr = new pageReference('/'+ proj.id);
        return pr;
    }
}