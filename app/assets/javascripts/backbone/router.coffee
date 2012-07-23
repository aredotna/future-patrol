class FP.Routers.Router extends Backbone.Router
  routes:
    ''      : 'home'
    ':slug' : 'fragment'

  initialize: ->
    channel = new FP.Models.Channel(slug: FP.source)
    FP.channels.insert(channel)

    @on 'ready', @ready, this

    FP.channels.on 'render:channel', @renderChannel
    FP.channels.on 'move:channel', @moveChannel

  ###
  Routes
  ###
  home: ->
    FP.channels.trigger('move:channel', FP.channels.at(0))

    @trigger 'ready'

  fragment: (slug) ->    
    channel = new FP.Models.Channel(slug: slug)
    FP.channels.insert(channel)

    @trigger 'ready'

  ###
  Display
  ###
  renderChannel: (channel) ->
    console.log 'render ...', channel.get('slug')
    view = new FP.Views.Channel(channel: channel, el: "##{channel.get('slug')}")

    if channel.get('position') is 1
      $(view.render()).hide().prependTo('#main').fadeIn 150
    else
      $(view.render()).hide().appendTo('#main').fadeIn 150, =>
        FP.channels.trigger('move:channel', channel)

  moveChannel: (channel) ->
    console.log 'move ...', channel.get('slug')
    $('#main').scrollTo("##{channel.get('slug')}", 150)

