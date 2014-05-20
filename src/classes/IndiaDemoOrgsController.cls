public class IndiaDemoOrgsController {
    
    public Boolean renNew { get; set; }
    public PageReference showNew() {
        renSave =true;
        return null;
    }
    public boolean renSave { get; set; }    
    public PageReference saveNewOrg() {
        insert demoOrg;
        renSave =false;
        return null;
    }
    public String demoOrgId{get;set;}
    public List<DemoOrgs__c > demoOrgsList{get;set;}
    public DemoOrgs__c  demoOrg{get;set;}
    public IndiaDemoOrgsController (){
        demoOrg=new DemoOrgs__c ();
        renSave =false;
        renNew=false;
        Set<Id> profileIds=new Set<Id>();
        List<String> pNames=new List<String>();
        pNames.add('System Administrator');
        pNames.add('Pre Sales Force One App');
        pNames.add('Project Lead Force One App');
        profileIds.addAll(new Map<Id,Profile>([select id from profile where name in:pNames ]).keySet());
        if(profileIds.contains(userInfo.getProfileId())){
            //System.assertEquals('',null);
            renNew=true;
        }
        demoOrgsList= [select id,Name,user_Name__c,password__c,Industry__c,Org_Type__c,Description__c from DemoOrgs__c where user_Name__c!=null and password__c!=null];
    }
    
    
}