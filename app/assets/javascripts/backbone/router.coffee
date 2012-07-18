class FP.Routers.Router extends Backbone.Router
  routes:
    ""      : "index"
    ":slug" : "fragment"

  index: ->
    # index

  fragment: (slug) ->
    view = new FP.Views.Stream(slug: slug, el: "##{slug}")