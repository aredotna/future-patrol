class FP.Models.Channel extends Backbone.Model
  initialize: ->
    @on "add", (model, collection, options) ->
      console.log "model:add", model, collection, options, options.index

  fetch: ->
    FP.Utils.startLoad()
    $.ajax
      url: "/#{@get('slug')}"
      success: (response) =>
        FP.Utils.stopLoad()
        @set { fragment: response }

  setFragment: -> @set { fragment: $("##{@get('slug')}").html() }