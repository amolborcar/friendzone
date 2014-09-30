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
  },

  getDatesOfTweets: function(){
    getDates = $.ajax({
      url: 'tweets/get_dates_of_tweets',
      type: 'GET'
    })

    getDates.success(function(data){
      chartOptions = this.createNumberOfTweetsTemplate(data);
      self.view.animateNumberOfTweetsChart(chartOptions);
    }.bind(this))

    getDates.fail(function(data){
      console.log("Failure!")
      console.log(data)
    })
  },

  getSentimentOfTweets: function(){
    getSentiments = $.ajax({
      url: 'tweets/get_sentiment_of_tweets',
      type: 'GET'
    })

    getSentiments.success(function(data){
      chartOptions = this.createNumberOfTweetsTemplate(data);
      console.log(data)
    }.bind(this))

    getDates.fail(function(data){
      console.log("Failure!")
      console.log(data)
    })
  },

  createNumberOfTweetsTemplate: function(counts){
    chartOptions = {
      chart: {
        type: 'column',
        backgroundColor: '#C0DEED',
        height: 400
      },
      title: {
        text: 'Your tweets per month'
      },
      xAxis: {
        min: 108,
        type: 'datetime',
        lineColor: 'black',
        lineWidth: 1,
        tickColor: 'black',
        categories: counts.dates
      },
      yAxis: {
        title: {
            text: 'Number of Tweets'
        },
        gridLineWidth: 0,
        lineColor: 'black',
        lineWidth: 1,
        tickColor: 'black',
        tickWidth: 1
      },
      scrollbar: {
        enabled: true,
        trackBackgroundColor: '#FFFFFF',
        trackBorderColor: '#D9D9D9',
        barBackgroundColor: '#939393',
        rifleColor: '#FFFFFF'
      },
      legend: {
        enabled: false
      },
      plotOptions: {
        column: {
          pointPadding: 0.2,
          borderWidth: 0
        }
      },
      series: [{
        color: '#2A469D',
        data: counts.values
      }]
    }
    return chartOptions
  }

}
