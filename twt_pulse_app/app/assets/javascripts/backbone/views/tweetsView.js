App.Views.TweetView = Backbone.View.extend({
  el: '#test',

  initialize: function() {
    console.log('@ tweet model');
    this.template = HandlebarsTemplates['tweets/search'];
    this.render();
  },

  render: function() {
    this.$el.html(this.template);
    // this.$el.html(this.template(this.model.toJSON()));
  }

})
