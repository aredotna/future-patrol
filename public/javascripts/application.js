$(function() {
  // Connection click
  $(document).on('click', '.connections a', function(e) {
    e.preventDefault();

    Utils.startLoad(this);

    $.ajax({
      url: $(this).attr('href'),
      success: function(response) {
        Utils.stopLoad();

        $(response)
          .hide()
          .appendTo('#main')
          .fadeIn(250, function() {
            var offset = 0;

            $('.column-wrap').each(function(index) {
              offset += $(this).width();
            });

            $('#main').animate({scrollLeft: offset}, 250);

          });
      }
    });
  });

  // Scroll back
  $(document).on('click', '#fp', function() {
    $('#main').animate({scrollLeft: 0}, 'fast');
  })
});

var Utils = {
  startLoad: function(_this) {
    $('#loading').show()
    $(_this).addClass('loading');
  },

  stopLoad: function() {
    $('#loading').hide();
    $('.connections a').removeClass('loading');
  }
}