class FP.Views.Channel extends Backbone.View
  initialize: (options) ->
    @channel = options.channel
    @fragment = @channel.get('fragment')

  events:
    'click .connection' : 'check'

  check: (e) ->
    console.log $(e.currentTarget)

  render: ->
    @fragment