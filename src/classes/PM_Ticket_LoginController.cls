global class PM_Ticket_LoginController {
    public Boolean ticketPage {get; set; }
    public Boolean loginPage {get; set; }
    public Connection__c con{get; set;}
    public Customer__c Customer{get;set;}
    public Ticket__c ticketinstance{get; set;}
    public blob Attach {get;set;} 
    public string contenttype {get;set;} 
    public String fileName {get; set;} 
    
    
    public PM_Ticket_LoginController(ApexPages.StandardController controller) {
        
        ticketinstance = new Ticket__c();
        loginPage =true;
        Attach =null;
        
    }
    
    
    
    public String Password { get; set; }
    
    public String UserName { get; set; }
    
    public PageReference cancel() {
        return null;
    }
    
    
    public pagereference login(){
        pagereference pr;
        if(UserName!=null && Password!=null && UserName!='' && Password!=''){
            try{
                
                con=[select id, name,User_Name__c,Password__c,Email__c, Customer__c from Connection__c where User_Name__c=:UserName];
                
                Customer=[Select id,name from  Customer__c where id=: con.Customer__c];
                if(con!=null && con.User_Name__c==UserName && con.Password__c ==Password  ){
                    system.debug(Password);
                    ApexPages.addMessage(new ApexPages.Message (ApexPages.Severity.confirm, 'loggedin sucessfully'));
                    //pr= new pagereference('/apex/userticketpage');
                    loginPage=false;
                    ticketPage=true;
                    
                    
                }else{
                    ApexPages.addMessage(new ApexPages.Message (ApexPages.Severity.error, 'Invalid Login credentials'));
                }
                
            }
            catch(Exception e){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'You are not aregistered user');
                ApexPages.addMessage(myMsg);
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message (ApexPages.Severity.ERROR, 'UN&PWD fields are required'));
        }
        
        
        return pr;
    }
    public pagereference attachFile(){
        Attachment att= new Attachment();
        return null;
    }
    public pagereference save(){
        
        ticketinstance.Connection__c=con.id;
        insert ticketinstance;
        
        if(Attach!=null){  
            blob b=attach;
            string contype=contenttype;
            String file=filename;
            Attachment At = new Attachment(name=file,body=b,contenttype=contype,parentId=ticketinstance.id);
            
            try{
                insert At;  
            }
            catch(System.DMLException e) {  
                ApexPages.addMessages(e);  
                return null;  
            }
        }
        pagereference pr = new pagereference('http://www.extentor.com');
        return pr;
        
    }
}