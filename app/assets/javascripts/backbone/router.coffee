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
    model = new FP.Models.Channel(slug: slug)
    FP.channels.add(model)
    $.when(model.fetch()).then(=> @render(model.get('fragment')))

  render: (fragment) ->
    @trigger 'render:pre'

    $(fragment).hide().appendTo("#main").fadeIn 250, ->
      offset = 0
      $(".column-wrap").each (index) ->
        offset += $(this).width()

      $("#main").animate
        scrollLeft: offset
      , 250

    @trigger 'render:post'

  preRender: ->
    # Pre-render

  postRender: ->
    # Post-render
    # TODO: Attach the view...
    # view = new FP.Views.Stream(slug: slug, el: "##{slug}")
    