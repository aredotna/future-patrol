class FP.Views.Channel extends Backbone.View
  initialize: (options) ->
    @channel = options.channel
    @fragment = @channel.get('fragment')

  events:
    'click .connection' : 'check'
    'click .preview'    : 'loadEmbed'

  check: (e) ->
    $(e.currentTarget).
      addClass('active').
      parent().
      addClass('active')

  loadEmbed: (e) ->
    $target = $(e.currentTarget)
    $embed = $($target.data('embed'))
    $embed.attr('src', "#{$embed.attr('src')}&autoplay=1")
    $target.replaceWith $embed

  render: ->
    @fragment