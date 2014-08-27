$(document).ready(function(){
  $('.searchform').on('submit', function(){
    appendTweets(event.target);
  })


  // tweetView = new Tweet.view();
  // tweetController = new Tweet.controller(tweetView);
})

var appendTweets = function(form){

    embeddedTweets = $.ajax({
      url: '/search',
      type: 'POST',
      data: $(form).serialize()
    })

    embeddedTweets.success(function(data){
      $('#tweet-list').hide().append(data).slideDown('slow');
    })

    embeddedTweets.fail(function(data){
      console.log("Failure!")
      console.log(data)
    })

}