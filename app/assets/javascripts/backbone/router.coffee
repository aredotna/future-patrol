class FP.Routers.Router extends Backbone.Router
  routes:
    ""      : "index"
    ":slug" : "fragment"

  index: -> console.log '@index'

  fragment: (slug) ->
    console.log '@fragment'
    view = new FP.Views.Stream(slug: slug)