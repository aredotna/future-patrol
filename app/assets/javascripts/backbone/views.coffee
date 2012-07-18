class FP.Views.Stream extends Backbone.View
  el: '.column-wrap'

  initialize: (options) ->
    @slug = options.slug

    FP.Utils.startLoad this

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