$(document).ready(function(){

  tweetView = new Tweet.View();
  tweetController = new Tweet.Controller(tweetView);
  tweetController.init();

})