public  with sharing class LM_AvailableLeaveClass {
    //move to Application Leave Page
    
    public PageReference movetopage() {
        string id=apexpages.currentpage().getparameters().get('rec');
        pagereference pr =new pagereference('/'+id);
        return pr;
    }
    // the soql without the order and limit
    public String soql {get;set;}
    // the collection of contacts to display
    public List<User> contacts {get;set;}
    Id roleId;
    Id userId;
    String userName;
    user usr;
    
    
    // the current sort direction. defaults to asc
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }
    
    // the current field to sort by. defaults to last name
    public String sortField {
        get  { if (sortField == null) {sortField = 'Name'; } return sortField;  }
        set;
    }
    
    
    // init the controller and display contact data whose account name=Extentor, when the page loads
    public LM_AvailableLeaveClass () {
        
        roleId=userinfo.getUserRoleId();
        userId=userinfo.getUserId();
        
        
        usr = [select Name,profileid,user.profile.name from user where id =:userId];
        system.debug(usr.name);
        
        if(usr.profile.name == 'System Administrator'){
            soql='select id, name,Total_Leave__c,Exit_Date__c from user where isActive=true'; 
            //where (Exit_Date__C= NULL AND IsActive=true)';
        }
        else if( usr.profile.name == 'HR One App User' )
        {  
            soql='select id, name,Total_Leave__c,Exit_Date__c from user where isActive=true '; 
        } 
        
        else{
            soql= 'Select id,Name,UserRoleId,Total_Leave__c,Exit_Date__c,UserRole.Name,user.profile.name from User where ((UserRole.ParentRoleId =:roleId AND Exit_Date__C= NULL AND IsActive=true AND  Project_Lead__c=:userId) OR (id=:userId))';
            //soql='select id, name,Total_Leave__c,Exit_Date__c from user where isActive=true '; 
        }
        
        runQuery();
    }
    
    // toggles the sorting of query from asc<-->desc
    public void toggleSort() {
        // simply toggle the direction
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        // run the query again
        runQuery();
    }
    
    // runs the actual query
    public void runQuery() {
        
        try {
            // contacts = Database.query(soql);
            contacts = Database.query(soql + ' order by ' + sortField + ' ' + sortDir);
            system.debug(contacts);
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid Query!'));
        } 
        
    }
    
    // runs the search with parameters passed via Javascript
    public PageReference runSearch() {
        
        String empname = Apexpages.currentPage().getParameters().get('name');
        if(usr.profile.name == 'System Administrator' )
        { 
            soql='select id, name,Total_Leave__c,Exit_Date__c from user where isActive=true'; 
        } 
        else if( usr.profile.name == 'HR One App User' )
        {  
            soql='select id, name,Total_Leave__c,Exit_Date__c from user where isActive=true '; 
        } 
        
        else{
            soql= 'Select id,Name,UserRoleId,Total_Leave__c,Exit_Date__c,UserRole.Name from User where ((UserRole.ParentRoleId =:roleId AND Exit_Date__C= NULL AND IsActive=true) OR username=:userName OR Project_Lead__c=:userId)';
        }
        if (!empname.equals('')){
            soql += ' and Name LIKE \''+String.escapeSingleQuotes(empname)+'%\'';
        }
        
        // run the query again
        runQuery();
        
        return null;
    }
}