class FP.Routers.Router extends Backbone.Router
  routes:
    ''      : 'home'
    ':slug' : 'fragment'

  initialize: ->
    channel = new FP.Models.Channel(slug: FP.source)
    FP.channels.insert(channel)
    view = new FP.Views.Channel(channel: channel)
    @attachView(view)


    @on 'activate:view', @activate
    @on 'activate:view', @attachView

    FP.channels.on 'render:channel', @renderChannel
    FP.channels.on 'move:channel', @moveChannel

    FP.channels.on 'activate:channel', @activateChannel
    FP.channels.on 'deactivate:channel', @deactivateChannel

  ###
  Routes
  ###
  home: ->
    channel = FP.channels.at(0)
    FP.channels.trigger('move:channel', channel)
    FP.channels.activate(channel)

    FP.view.activateMenu()

  fragment: (slug) ->    
    channel = new FP.Models.Channel(slug: slug)
    FP.channels.insert(channel)
    FP.channels.activate(channel)

    FP.view.deactivateMenu()

  ###
  Display
  ###
  activateChannel: (channel) ->
    # console.log 'activate', channel.get('slug')

  deactivateChannel: (channel) ->
    # console.log 'deactivate', channel.get('slug')

  attachView: (view) ->
    view.setElement("##{view.channel.get('slug')}")

  renderChannel: (channel) =>
    view = new FP.Views.Channel(channel: channel, el: "##{channel.get('slug')}")

    if channel.get('position') is 1
      $(view.render()).hide().prependTo('#main').fadeIn 150
    else
      $(view.render()).hide().appendTo('#main').fadeIn 150, =>
        FP.channels.trigger('move:channel', channel)

    @trigger('activate:view', view)

  moveChannel: (channel) ->
    # Make sure visible
    $('.document').removeClass('active')
    $("##{channel.get('slug')}").fadeIn(150).find('.document').addClass('active')
    $('#main').scrollTo("##{channel.get('slug')}", 150)

