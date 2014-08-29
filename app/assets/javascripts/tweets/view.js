Tweet.View = function(){}

Tweet.View.prototype = {
  displayEmbeddedTweets: function(tweets){
    $('#tweet-list').empty().append(tweets).slideDown('slow');
    executeTweetFormatter();
  },
  initiateTypeahead: function(){
    $('#search-box').typeahead([
    {
      name: "names",
      local: ["amol", "something"]
    }
    ])
  }
}