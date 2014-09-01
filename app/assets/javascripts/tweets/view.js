Tweet.View = function(){}

Tweet.View.prototype = {
  displayEmbeddedTweets: function(tweets){
    $('#tweet-list').empty().append(tweets).slideDown('slow');
    executeTweetFormatter();
  },
  initiateTypeahead: function(nameList){

    nameList.initialize();

    $('#search-box').typeahead(
    {
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      name: 'friends',
      displayKey: 'value',
      source: nameList.ttAdapter()
    })
  }
}