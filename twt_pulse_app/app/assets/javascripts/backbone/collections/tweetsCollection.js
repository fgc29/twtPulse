App.Collections.TweetsCollection = Backbone.Collection.extend({
  model: App.Models.Tweet,
  url: '/tweets/search'
});
