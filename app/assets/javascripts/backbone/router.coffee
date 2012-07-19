class FP.Routers.Router extends Backbone.Router
  routes:
    ""      : "home"
    ":slug" : "fragment"

  initialize: ->
    @index() unless FP.Utils.startingOnIndex()

  home: ->
    # Nothing to see here.

  index: ->
    channel = new FP.Models.Channel(slug: FP.source)
    @fragment(channel.get('slug'), 'pre')

  fragment: (slug, position='post') ->
    channel = new FP.Models.Channel(slug: slug)
    slugs = FP.channels.pluck('slug')
    
    unless _.include(slugs, slug)
      FP.channels.add(channel)
      $.when(channel.fetch()).then(=>
          view = new FP.Views.Channel(channel: channel, el: "##{channel.get('slug')}")
          @render(view, position)
        )
    else
      @moveTo(channel)

  render: (view, position) ->
    if position is 'post'
      $(view.render()).hide().appendTo('#main').fadeIn 250, => @postRender(view)
    else
      $(view.render()).hide().prependTo('#main').fadeIn 250, => @postRender(view)

  postRender: (view) ->
    @moveTo(view.channel)
    view.setElement("##{view.channel.get('slug')}")

  moveTo: (channel) ->
    $('#main').scrollTo("##{channel.get('slug')}", 'fast')
    @activate('document', channel)
  
  activate: (selector, channel) ->
    $(".#{selector}").removeClass('active')
    $("##{selector}_#{channel.get('slug')}").addClass('active')