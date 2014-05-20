trigger PM_UpdateSalesorderItemsStatus on Invoice_Line_Item__c (before insert,after update) {
    
    List<Consolidated_Time_Sheet__c> ConsolidatedItems= new List<Consolidated_Time_Sheet__c>();
    List<Sales_Order_Item__c> salesOrderItems= new List<Sales_Order_Item__c>();
    List<id> ConsolidatedIds= new List<id>();
    List<id> salesOrderItemIds= new List<id>();
    system.debug(ConsolidatedIds.size());
                system.debug(salesOrderItemIds.size());
    Map<Id,Decimal> lineItem_Qty_Map = new Map<Id,Decimal>();
    Map<Id,Decimal> lineItem_Qty_Map_SO = new Map<Id,Decimal>();
    
    
        for(Invoice_Line_Item__c invoiceLineItem:Trigger.new){
            if (Trigger.isInsert || Trigger.oldMap.get(invoiceLineItem.Id).Invoice_Quantity__c != invoiceLineItem.Invoice_Quantity__c) {
                ConsolidatedIds.add(invoiceLineItem.Consolidated_Time_Sheet__c);
                salesOrderItemIds.add(invoiceLineItem.Sales_Order_Item__c);
                system.debug('abc'+salesOrderItemIds);
                system.debug('def'+ConsolidatedIds);
                lineItem_Qty_Map_SO.put(invoiceLineItem.Sales_Order_Item__c,invoiceLineItem.Invoice_Quantity__c);
                lineItem_Qty_Map.put(invoiceLineItem.Consolidated_Time_Sheet__c,invoiceLineItem.Invoice_Quantity__c);
                system.debug('ghi'+lineItem_Qty_Map_SO);
                system.debug('ghi'+lineItem_Qty_Map);
                system.debug(ConsolidatedIds.size());
                system.debug(salesOrderItemIds.size());
            }
         }  
         if(ConsolidatedIds.size()>0){
        for(Consolidated_Time_Sheet__c consolidatedItem:[select id,Quantity__c from Consolidated_Time_Sheet__c where id IN:ConsolidatedIds]){
            Decimal invoiceLineQuantity = lineItem_Qty_Map.get(consolidatedItem.Id);
          if(invoiceLineQuantity == consolidatedItem.Quantity__c){
           
                consolidatedItem.Status__c='Completely Invoiced';
                ConsolidatedItems.add(consolidatedItem);
            }
            else{
            consolidatedItem.Status__c='Partially Invoiced';
             ConsolidatedItems.add(consolidatedItem);
            }
        }
        }
         if(salesOrderItemIds.size()>0){
        for(Sales_Order_Item__c salesorderItem:[select id,Quantity__c from Sales_Order_Item__c where id IN:salesOrderItemIds]){
            Decimal invoiceLineQuantity = lineItem_Qty_Map_SO.get(salesorderItem.Id);
            system.debug('abc' +invoiceLineQuantity);
          if(invoiceLineQuantity == salesorderItem.Quantity__c){
           
           system.debug('abc' + salesorderItem.Quantity__c);
                salesorderItem.Status__c='Completely Invoiced';
                salesOrderItems.add(salesorderItem);
            }
            else{
            salesorderItem.Status__c='Partially Invoiced';
             salesOrderItems.add(salesorderItem);
            }
        }
        }if(ConsolidatedItems.size()>0){
        system.debug(ConsolidatedItems);
       Database.update(ConsolidatedItems);
       }else
       {
       system.debug(salesOrderItems);
       Database.update(salesOrderItems);
       }
    }