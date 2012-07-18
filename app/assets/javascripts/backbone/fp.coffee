#= require_self
#= require ./views
#= require ./router

window.FP =
  Models: {},
  Collections: {},
  Routers: {},
  Views: {},
  Utils:
    startLoad: (_this) ->
      $("#loading").show()
      $(_this).addClass "loading"

    stopLoad: ->
      $("#loading").hide()
      $(".connections a").removeClass "loading"

  initialize: ->
    @router = new FP.Routers.Router()

    Backbone.history.start({pushState: true})

    # Intercept internal links
    $(document).on "click", "a:not([data-bypass])", (e) =>
      href = $(e.currentTarget).attr("href")
      protocol = e.currentTarget.protocol + "//"
      if href.slice(protocol.length) isnt protocol
        e.preventDefault()
        @router.navigate href, true

$ -> FP.initialize()