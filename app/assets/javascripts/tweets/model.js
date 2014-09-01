Tweet.Model = function(){}

Tweet.Model.prototype = {
  getSearchSuggestions: function(){

    getNames = $.ajax({
      url: '/find_all_names',
      type: 'GET'
    })

    getNames.success(function(data){
      this.constructSuggestionEngine(data);
    }.bind(this))

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
    var suggestions = new CustomEvent('suggestions', {
      detail: {
        nameList: nameList
      }
    })
    document.dispatchEvent(suggestions)
  }

}