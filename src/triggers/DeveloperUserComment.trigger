trigger DeveloperUserComment on FeedComment (Before Insert) {
 for(FeedComment feedcomment : trigger.new){
        if(feedcomment .CommentType== 'TextComment'||feedcomment .CommentType== 'ContentComment'){
         Profile p = [SELECT Id FROM Profile WHERE Name='Chatter Free User'];
          User user = [SELECT Id,Name,ProfileId FROM User WHERE Id =:Userinfo.getUserId()];
           if(user.ProfileId == p.Id){         
            feedcomment.addError('Sorry, You Cannot comment !!');
            }
          }
       }
}