$(function() {
  // Connection click
  $(document).on('click', '.connections a', function(e) {
    e.preventDefault();

    $('#loading').show()
    $(this).addClass('loading');

    $.ajax({
      url: $(this).attr('href'),
      success: function(response) {
        $('#loading').hide();
        $('.connections a').removeClass('loading')
        $('#main').append(response);
        
        var _peek = 250;
        var _offset = $('#main').width() - $('.column-wrap').last().width() - _peek;
        $('body').animate({scrollLeft: _offset}, 'fast');
      }
    });
  });

  // Reset
  $(document).on('click', '#fp', function() {
    $('body').animate({scrollLeft: 0}, 'fast');
  })
});

// Bullshit
var Utils = {
  lazy: function() {
    $('img').lazyload({
      container: $(".stream"),
      effect : "fadeIn",
      threshold : 200
    });
  }
}