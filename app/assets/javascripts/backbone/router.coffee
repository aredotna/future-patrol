class FP.Routers.Router extends Backbone.Router
  routes:
    ""      : "home"
    ":slug" : "fragment"

  initialize: ->
    @index() unless FP.Utils.startingOnIndex()
    @pos = 0
    $(document).on "click", "a:not([data-bypass])", @clearForward

  home: -> 
    channel = new FP.Models.Channel({slug: FP.source, position: 0})
    FP.channels.add(channel)
    view = new FP.Views.Channel(channel: channel, el: "##{channel.get('slug')}")
    view.setElement("##{view.channel.get('slug')}")


  clearForward: (e) ->
    $channel_container = $(e.target).closest('.column-wrap') # find this channel
    slug = $channel_container.attr 'id'
    
    current = FP.channels.where {slug: slug} # remove all channels in front of it in collection
    if current[0]?
      bar = current[0].get 'position'

      # no longer relevant
      nlr = FP.channels.filter (model) -> model.get('position') > bar
      FP.channels.remove nlr

      $channel_container.nextAll().remove()

  index: ->
    channel = new FP.Models.Channel(slug: FP.source)
    @fragment(channel.get('slug'), 'pre')

  fragment: (slug, position='post') ->
    channel = new FP.Models.Channel(slug: slug)
    slugs = FP.channels.pluck('slug')
    
    unless _.include(slugs, slug)
      FP.channels.add(channel)
      $.when(channel.fetch()).then =>
        view = new FP.Views.Channel(channel: channel, el: "##{channel.get('slug')}")
        @render(view, position)
    else
      @moveTo(channel)

  render: (view, position) ->
    if position is 'post'
      $(view.render()).hide().appendTo('#main').fadeIn 150, => @postRender(view, 'appended')
    else
      $(view.render()).hide().prependTo('#main').fadeIn 150, => @postRender(view, 'prepended')

  postRender: (view, position) ->
    @moveTo(view.channel)
    view.setElement("##{view.channel.get('slug')}")
    view.channel.set 'position', ++@pos

  moveTo: (channel) ->
    $('#main').scrollTo("##{channel.get('slug')}", 'fast')
    @activate('document', channel)
  
  activate: (selector, channel) ->
    $(".#{selector}").removeClass('active')
    $("##{selector}_#{channel.get('slug')}").addClass('active')