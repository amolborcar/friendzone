Tweet.Controller = function(view){
  this.view = view;
  self = this
}

Tweet.Controller.prototype = {

  init: function(){
    this.bindEventListeners();
    this.getAllNames();
  },

  bindEventListeners: function(){

    $('#search-form').on('submit', function(){
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
  },

  getAllNames: function(){
    getNames = $.ajax({
      url: '/find_all_names',
      type: 'GET'
    })

    getNames.success(function(data){
      self.constructSuggestionEngine(data);
    })

    getNames.fail(function(data){
      console.log(data)
      console.log('failure!')
    })
  },

  constructSuggestionEngine: function(names){
    var nameList = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: $.map(names, function(name){
        return { value: name };
      })
    });
    self.view.initiateTypeahead(nameList);

  }

}