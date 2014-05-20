trigger PM_Project_addError on Project__c(before insert) {
    
    for(Project__c pro:Trigger.new){
        List<Project__c> proj=[select name,Sales_Order__c from project__c where Sales_Order__c=:pro.Sales_Order__c];
        if(proj.size()>=1){
            pro.addError('You can\'t create more than one project for a salesorder');
            
        }
    }
    
}