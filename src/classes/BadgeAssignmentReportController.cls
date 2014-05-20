public class BadgeAssignmentReportController{
    
    
    
    
    public string un { get; set; }
    public List<WorkBadge> badges { get; set; }
    public List<WorkBadge> listbadges{get; set;}
    public Boolean badgeListSize{get;set;}
    public boolean noBadgeMsg{get;set;}
    public String fromDate{get;set;}
    public String toDate{get;set;}
    public BadgeAssignmentReportController(){
        badges =new List<WorkBadge>();
        noBadgeMsg = false;
    }
    
    public PageReference generateBadgeReport() {
        if(badges.size()>0){
            badges.clear();
            badgeListSize =false;
            noBadgeMsg = false;
        }
        
        
        
        Date myfromDate;
        Date mytoDate;
        
        try{
            
            
            String[] tempStr = fromDate.split('/');
            Integer m = Integer.valueOf(tempStr[0]);
            Integer d = Integer.valueOf(tempStr[1]);
            Integer y = Integer.valueOf(tempStr[2]);
            myfromDate= Date.newInstance(y,m,d);
            
            
            
            String[] tempStr1 = toDate.split('/');
            Integer m1 = Integer.valueOf(tempStr1[0]);
            Integer d1 = Integer.valueOf(tempStr1[1]);
            Integer y1 = Integer.valueOf(tempStr1[2]);
            mytoDate = Date.newInstance(y1,m1,d1);
            if(myfromDate>mytoDate){
                
                noBadgeMsg = false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'To Date Should Be Greater Than From Date')); 
                
            }
            
            listbadges = new List<WorkBadge>();
            if(un == null || un=='--None--'){
                listbadges=[select id,RecipientId,CreatedById,Definition.imageUrl,Definition.Description,CreatedDate from WorkBadge where CreatedDate >=:myFromDate and CreatedDate <=:mytoDate];         
            }
            else{
                
                listbadges=[select id,RecipientId,CreatedById,Definition.imageUrl,Definition.Description,CreatedDate from WorkBadge where RecipientId=:un and CreatedDate >=:myFromDate and CreatedDate <=:mytoDate]; 
            }
            
            // system.assertEquals(listbadges,null);
            
            badges.addall(listbadges );
            badgeListSize = badges.size()>0? true:false;
            noBadgeMsg = badges.size()==0 && myfromDate<mytoDate? true:false;
        }catch(Exception e){
            noBadgeMsg =false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Enter Valid Dates')); 
            
        }
        return null;
    }
    
    public List<selectoption> options=new List<selectoption>();
    public List<selectoption> getPickvaluesTest() {
        //profile userProfile =[select id from profile where name ='Chatter Free User' limit 1];
        if(options.size()>0){
            options.clear();    
        }
        options.add(new selectoption('--None--','--None--'));
        for(User us:[select id,Name from User where isactive = true order by name asc])
        {
            options.add(new selectoption(us.id,us.Name));
        } 
        
        return options;
        
    }
    
}