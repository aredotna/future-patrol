#= require_self
#= require ./models
#= require ./collections
#= require ./views
#= require ./router




window.FP =
  source: 'semblance',
  
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},

  Utils:
    startLoad: ->
      $("#fp").addClass('loading')

    stopLoad: ->
      $("#fp").removeClass('loading')

    interceptLinks: (context) ->
      $(document).on "click", "a:not([data-bypass])", (e) =>
        href = $(e.currentTarget).attr("href")
        protocol = e.currentTarget.protocol + "//"
        if href.slice(protocol.length) isnt protocol
          e.preventDefault()
          context.router.navigate href, true

    startingOnIndex: ->
      Backbone.history.location.pathname is '/'

  initialize: ->
    @channels = new FP.Collections.Channels()
    @router = new FP.Routers.Router()
    Backbone.history.start({pushState: true})
    @Utils.interceptLinks(this)

$ -> FP.initialize()