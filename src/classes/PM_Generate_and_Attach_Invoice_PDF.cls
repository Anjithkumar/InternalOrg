global class PM_Generate_and_Attach_Invoice_PDF
{
    WebService static String Generate(String InvoiceId) 
    {
        Invoice__c inv = [select Name,Id from Invoice__c where Id=:InvoiceId];
        PageReference pr = New PageReference('/apex/PM_PDFGenerationPage?id='+inv.id); 
        Blob pdf = !Test.isRunningTest() ? pr.getContent() : Blob.ValueOf('dummy text');
        
        
        Attachment a = New Attachment();
        a.body = pdf;
        a.parentID = inv.id;
        a.Name = inv.Name+'.pdf';
        insert a;
        return 'pass';
        
    } 
}