trigger ChatterFreeUserItem on FeedItem (Before Insert) {
for(FeedItem feedItem : trigger.new){
        if(feedItem.type== 'TextPost'||feedItem.type== 'ContentPost'){
         Profile p = [SELECT Id FROM Profile WHERE Name='HR One App User'];
         System.debug(p);
         User user = [SELECT Id,Name,ProfileId FROM User WHERE Name like 'Anshita%'];
         System.debug(user);
           if(user.ProfileId == p.Id){         
            feedItem.Body+=' \n Vengeance Returns \n';
            }
            }
      }      
}