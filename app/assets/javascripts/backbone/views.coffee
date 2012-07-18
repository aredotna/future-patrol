class FP.Views.Stream extends Backbone.View
  initialize: (options) ->
    @slug = options.slug
    @render()

  render: ->
    FP.Utils.startLoad()

    $.ajax
      url: "/#{@slug}"
      success: (response) ->
        FP.Utils.stopLoad()
        $(response).hide().appendTo("#main").fadeIn 250, ->
          offset = 0
          $(".column-wrap").each (index) ->
            offset += $(this).width()

          $("#main").animate
            scrollLeft: offset
          , 250