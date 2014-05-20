global class PM_ProjectAllocation {
    
    /* To create project allocation records 

Author: Ashwin 

Created Date :

Last Modified Date :25/09/2013

Reason: To fetch roles from the custom setting 


*/
    public Boolean refreshPage{get;set;}
    public Boolean WholePage{get;set;}
    public String selectedValue{get;set;}
    Public Allocation__c ProjectAllocation; 
    Public List<Allocation__c> fetchAllocation {get;set;}
    public String selectedRole{get;set;}
    
    //To get allocated roles from the resource forecast 
    public List<SelectOption> getAvailableRoles()
    {
        List<SelectOption> options = new List<SelectOption>();
       /* for(Resource_Forecast__c dealItem: [select Role__c from Resource_Forecast__c where Deal__c = :selectedProject .Sales_Order__r.Deal__c])
        {
            options.add( new SelectOption(dealItem.Role__c, dealItem.Role__c));
        }*/
         for(Services__c roles: [select name from Services__c])
        {
            options.add( new SelectOption(roles.name, roles.name));
        }
        return options;
    }
    
    Public Project__c  selectedProject  {get;set;}
    id projectid ;
    //Controller 
    Public PM_ProjectAllocation(ApexPages.StandardController controller)
    {
        projectid=ApexPages.currentPage().getParameters().get('id');
        selectedProject =[Select name,id,Sales_Order__r.Deal__c from Project__c where id=:projectid][0];
        
        resetQueries();
    }
    // To get show the created project allocation records for the corresponding project
    public void resetQueries()
    {
        fetchAllocation =[Select Assigned_User__c,Role__c,Project__c,Start_Date__c, Location__c,Percentage__c,End_Date__c from Allocation__c where Project__c =:selectedProject .id ]; 
    }
    
    
    public Allocation__c  getAllocation(){
        ProjectAllocation = new Allocation__c();
        return ProjectAllocation;
    } 
    
    // To Create the project allocation 
    public pageReference Add()
    {
        try{
            if( ProjectAllocation.Assigned_User__c!=null )
            {
                
                ProjectAllocation.Project__c=selectedProject .id;
                ProjectAllocation.Role__c = selectedRole;
                database.insert(ProjectAllocation);
                ProjectAllocation = new Allocation__c();
            }
            resetQueries();
            
        }
        catch (Exception ex) {
            ApexPages.addMessages(ex);
        }
        return null;
    }
    //To delete the created project allocation record 
    public PageReference remove() 
    {
        selectedValue=ApexPages.currentPage().getParameters().get('removeRow');
        Allocation__c DeleteAllocation=new Allocation__c(id=selectedValue);
        delete DeleteAllocation ;
        resetQueries();
        return null;
        
    }
}