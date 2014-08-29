Tweet.Controller = function(view){
  this.view = view;
  self = this
}

Tweet.Controller.prototype = {

  init: function(){
    this.bindEventListeners();
    this.view.initiateTypeahead();
  },

  bindEventListeners: function(){
    $('.searchform').on('submit', function(){
      self.loadEmbeddedTweets(event.target);
    })
  },

  loadEmbeddedTweets: function(form){
    embeddedTweets = $.ajax({
      url: '/search',
      type: 'POST',
      data: $(form).serialize()
    })

    embeddedTweets.success(function(data){
      self.view.displayEmbeddedTweets(data);
    })

    embeddedTweets.fail(function(data){
      console.log("Failure!")
      console.log(data)
    })
  }

}