$ ->
  $(document).on "click", ".connections a", (e) ->
    e.preventDefault()
    Utils.startLoad this
    $.ajax
      url: $(this).attr("href")
      success: (response) ->
        Utils.stopLoad()
        $(response).hide().appendTo("#main").fadeIn 250, ->
          offset = 0
          $(".column-wrap").each (index) ->
            offset += $(this).width()

          $("#main").animate
            scrollLeft: offset
          , 250

  $(document).on "click", "#fp", ->
    $("#main").animate
      scrollLeft: 0
    , "fast"

Utils =
  startLoad: (_this) ->
    $("#loading").show()
    $(_this).addClass "loading"

  stopLoad: ->
    $("#loading").hide()
    $(".connections a").removeClass "loading"