class FP.Views.Channel extends Backbone.View
  initialize: (options) ->
    @slug = options.slug

  events:
    'click .connection' : 'check'

  check: (e) ->
    console.log $(e.currentTarget)