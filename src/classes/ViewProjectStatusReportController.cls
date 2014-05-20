public with sharing class ViewProjectStatusReportController {
    
    private final Integer pageSize = 15;    
    private Integer pageNumber;
    
    public  ViewProjectStatusReportController()
    {
        pageNumber = 0;
        sortExpression = 'Type';
        sortDirection = 'Desc';
        ViewData();
    }
    
    public pageReference ViewData(){
        SortData(1);
        return null;
    }
    public String sortExpression{get;set;}
    public String sortDirection{get;set;}
    
    public Void SortData(Integer SortBy){
        projectDealWrapperList = new List<ProjectsDealsWrapper>();
        
        List<Allocation__c> allocationList = [Select Project__r.Name, Role__c, Start_Date__c, End_Date__c From Allocation__c Where Project__r.Status__c NOT IN ('Completed', 'Closed')];
        List<Resource_Forecast__c> resourceForecastList = [Select  Deal__r.Name, Role__c, Start_Date__c, End_Date__c From Resource_Forecast__c Where Deal__r.Stage__c NOT IN ('Closed Lost', 'Close Dropped')];
        string sortFullExp = sortExpression  + ' ' + sortDirection;
        if(sortDirection == 'Asc' && sortExpression == 'Type'){
            for(Resource_Forecast__c RF: resourceForecastList){
                projectDealWrapperList.add(new ProjectsDealsWrapper(RF.Deal__r.Name, RF.Role__c, 1, RF.Start_Date__c, RF.End_Date__c, 'Deal'));
            }
            for(Allocation__c a: allocationList){
                projectDealWrapperList.add(new ProjectsDealsWrapper(a.Project__r.Name, a.Role__c, 1, a.Start_Date__c, a.End_Date__c, 'Project'));
            }
            
        }else{
            for(Allocation__c a: allocationList){
                projectDealWrapperList.add(new ProjectsDealsWrapper(a.Project__r.Name, a.Role__c, 1, a.Start_Date__c, a.End_Date__c, 'Project'));
            }
            for(Resource_Forecast__c RF: resourceForecastList){
                projectDealWrapperList.add(new ProjectsDealsWrapper(RF.Deal__r.Name, RF.Role__c, 1, RF.Start_Date__c, RF.End_Date__c, 'Deal'));
            }
        }

    }    
    
    public List<ProjectsDealsWrapper> projectDealWrapperList {get;set;}

    private List<List<ProjectsDealsWrapper>> list_Pages
    {
        get
        {
            if ( list_Pages == null )
            {
                list_Pages = new List<List<ProjectsDealsWrapper>>();
                Integer numInPage = pageSize;
                List<ProjectsDealsWrapper> thePage;
                for ( ProjectsDealsWrapper cCon : projectDealWrapperList)
                {
                    if ( numInPage >= pageSize )
                    {
                        thePage = new List<ProjectsDealsWrapper>();
                        list_Pages.add( thePage );
                        numInPage = 0;
                    }
                    thePage.add( cCon );
                    numInPage++;
                }
            }
            return list_Pages;
        }
        private set;
    }

    public  List<ProjectsDealsWrapper> currentPage  { get { return list_Pages[ pageNumber ]; } }

    public  Boolean hasPrevious         { get { return pageNumber > 0; } }
    public  Boolean hasNext             { get { return pageNumber < list_Pages.size() - 1; } }

    public  void previousPage()         { if ( hasPrevious  ) pageNumber--; }
    public  void nextPage()             { if ( hasNext      ) pageNumber++; }

    public class ProjectsDealsWrapper{
        public String Description{get;set;}
        public String userRole{get;set;}
        public Integer noOfPerson{get;set;}
        public Date startDate{get;set;}
        public Date endDate{get;set;}
        public String Type{get;set;}
        
        public ProjectsDealsWrapper(String pdDescription, String uRole,Integer nPerson, Date sDate, Date eDate, String pdType)
        {
            Description = pdDescription;
            userRole = uRole;        
            noOfPerson = nPerson;
            startDate = sDate; 
            endDate = eDate;
            Type = pdType;
        }
    }
}