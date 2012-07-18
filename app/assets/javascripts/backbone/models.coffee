class FP.Models.Channel extends Backbone.Model
  fetch: ->
    FP.Utils.startLoad()
    $.ajax
      url: "/#{@get('slug')}"
      success: (response) =>
        FP.Utils.stopLoad()
        @set { fragment: response }