$(document).ready(function(){

  tweetView = new Tweet.View();
  tweetModel = new Tweet.Model();
  tweetController = new Tweet.Controller(tweetView, tweetModel);
  tweetController.init();

})