Tweet.Controller = function(view, model){
  this.view = view;
  this.model = model;
  self = this
}

Tweet.Controller.prototype = {

  init: function(){
    this.bindEventListeners();
    this.model.getSearchSuggestions();
  },

  bindEventListeners: function(){

    document.addEventListener('suggestions', function(){
      self.view.loadSearchSuggestions(event.detail.nameList);
    })

    $('#search-form').on('submit', function(){
      self.loadEmbeddedTweets(event.target);
      self.model.getDatesOfTweets();
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
  },

}