Tweet.View = function(){}

Tweet.View.prototype = {
  displayEmbeddedTweets: function(tweets){
    $('#tweet-list').empty().append(tweets).slideDown('slow');
    executeTweetFormatter();
  }
}