class FP.Routers.Router extends Backbone.Router
  routes:
    ""      : "index"
    ":slug" : "fragment"

  initialize: ->
    @on 'render:pre',  @preRender,  this
    @on 'render:post', @postRender, this

  index: ->
    # index

  fragment: (slug) ->
    channel = new FP.Models.Channel(slug: slug)
    FP.channels.add(channel)
    $.when(channel.fetch()).then(=> @render(channel))

  render: (channel) ->
    @trigger 'render:pre'

    $(channel.get('fragment')).hide().appendTo('#main').fadeIn 250, ->
      totals = $('.column-wrap').map(-> $(this).width())
      offset = _.reduce(totals, ((memo, num) -> memo + num), 0)
      $('#main').animate({ scrollLeft: offset }, 250)

    @trigger 'render:post'

  preRender: ->
    # Pre-render

  postRender: ->
    # Post-render
    