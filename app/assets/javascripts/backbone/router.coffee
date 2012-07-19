class FP.Routers.Router extends Backbone.Router
  routes:
    ""      : "index"
    ":slug" : "fragment"

  index: ->
    # index

  fragment: (slug) ->
    channel = new FP.Models.Channel(slug: slug)
    slugs = FP.channels.pluck('slug')
    
    unless _.include(slugs, slug)
      FP.channels.add(channel)
      $.when(channel.fetch()).then(=> @render(channel))
    else
      @moveTo(channel)

  render: (channel) ->
    $(channel.get('fragment')).hide().appendTo('#main').fadeIn 250, =>
      @moveTo(channel)

  moveTo: (channel) ->
    $('#main').scrollTo("##{channel.get('slug')}", 'fast')
    @activate('document', channel)
  
  activate: (selector, channel) ->
    $(".#{selector}").removeClass('active')
    $("##{selector}_#{channel.get('slug')}").addClass('active')