class FP.Views.Channel extends Backbone.View
  initialize: (options) ->
    @channel = options.channel
    @fragment = @channel.get('fragment')

  events:
    'click .connection' : 'activiate'
    'click .preview'    : 'loadEmbed'

  activiate: (e) ->
    @target = $(e.currentTarget)

    @check()
    @deactivate()

    @target.
      addClass('active').
      parent().
      addClass('active')

  deactivate: ->
    @$('.active').removeClass('active')


  check: ->
    @target.data('context')

  loadEmbed: (e) ->
    $target = $(e.currentTarget)
    $embed = $($target.data('embed'))
    $embed.attr('src', "#{$embed.attr('src')}&autoplay=1")
    $target.replaceWith $embed

  render: ->
    @fragment