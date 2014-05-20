global class PM_Generate_and_Attach_SO_PDF1
{
    WebService static String Generate(String SalesOrderId) 
    {
        Sales_Order__c so = [select Name,Id from Sales_Order__c  where Id=:SalesOrderId];
        PageReference pr = New PageReference('/apex/PM_SalesOrderPDFGenerator?id='+so.id); 
        Blob pdf = !Test.isRunningTest() ? pr.getContent() : Blob.ValueOf('dummy text');
        
        Attachment a = New Attachment();
        a.body = pdf;
        a.parentID = so.id;
        a.Name = so.Name+'.pdf';
        insert a;
        return 'success';
    }
}