Public class LM_CustomSetting 

{
    public LM_CustomSetting__c LM = new LM_CustomSetting__c() ; 
    public list<LM_CustomSetting__c> fetchPerviousRecord{get;set;}
    public LM_CustomSetting__c fetchCurrentRecord{get;set;}
    public String frequecnyOfRun { get; set; }
    public Boolean renderSection2 { get; set; }
    public Boolean renderSection1 { get; set; }
    public Boolean renderSection3 { get; set; } 
    
    public Boolean editSection { get; set; } 
    
    public LM_CustomSetting(ApexPages.StandardController controller) 
    {   
        this.LM = (LM_CustomSetting__c)controller.getRecord();
        currentRecord();
        previousRecord();
        renderSection1=true;
        renderSection2=false;
        renderSection3=true;
        editSection=false;
        
    }
    
    
    public List<SelectOption> getFrequecny() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1','Quarterly'));
        options.add(new SelectOption('2','Half Yearly'));
        options.add(new SelectOption('3','Monthly'));
        
        
        return options;
    }
    Public void add()
    {
        fetchPerviousRecord.add(fetchCurrentRecord);
        
        fetchCurrentRecord = new LM_CustomSetting__c();
        fetchCurrentRecord.Active__c = true ;
        
        renderSection1=false;
        renderSection2=true;
        
    }
    public void customEdit()
        
    {
        renderSection1=false;
        editSection=true;
        
    }
    
    
    Public void currentRecord()
    {
        renderSection2=false;
        fetchCurrentRecord =[Select name,  Active__c,  Frequncy_Of_Run__c,No_Of_Annual_Leaves__c, No_of_leaves_to_be_carry_forward__c, Year__c,Frequency_Text__c from LM_CustomSetting__c where Active__c = true];
    }
    
    
    Public void previousRecord()
    {
        System.debug('--------------------------------------------------');
        fetchPerviousRecord =[Select name,  Active__c,  Frequncy_Of_Run__c,No_Of_Annual_Leaves__c, No_of_leaves_to_be_carry_forward__c, Year__c,Frequency_Text__c from LM_CustomSetting__c   where Active__c = false];
    }
    
    public PageReference Cancel()
    {
        PageReference pg=new PageReference('/apex/LM_CustomSettings');
        pg.setRedirect(true);
        return pg;
        
    }
    
    public PageReference save()
    {
        try{
            renderSection1=false;
            renderSection3=true;  
            editSection=false;
            System.debug('--------------------'+FrequecnyOfRun);
            
            if(frequecnyOfRun=='1')
            {
                fetchCurrentrecord.Frequency_Text__c= 'Quarterly';
                fetchCurrentRecord.Frequncy_Of_Run__c='1;4;7;10';
                
            }
            else if (frequecnyOfRun=='2')
            {
                fetchCurrentrecord.Frequency_Text__c= 'Half yearly';
                fetchCurrentRecord.Frequncy_Of_Run__c='1;6';
                
            }
            
            else 
            {
                
                fetchCurrentrecord.Frequency_Text__c= 'Monthly';
                fetchCurrentRecord.Frequncy_Of_Run__c='1;2;3;4;5;6;7;8;9;10;11;12';
                
            }
            
            for(LM_CustomSetting__c lm1 : fetchPerviousRecord)
            {
                lm1.Active__c= false;
                update lm1;
            }
            
            
            upsert fetchCurrentRecord;
            
            //PreviousRecord();
            LM=new LM_CustomSetting__c();
            
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Leave Allocation has done Successfully'));
            //PageReference pg=new PageReference('/setup/ui/viewCustomSettingsData.apexp?id='+LM.Id);
            //pg.setRedirect(true);
            //return pg;
            
            
            
        }
        catch(Exception e)
        {
        }
        renderSection1=true;
        renderSection2=false;
        return null;
    }
    //LM_CustomSetting__c lm = new LM_CustomSetting__c();
    
}