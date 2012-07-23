###
Application
###
class FP.Views.Application extends Backbone.View
  activateMenu: ->
    @$('#primary').addClass('active')

  deactivateMenu: ->
    @$('#primary').removeClass('active')

###
Channel
###
class FP.Views.Channel extends Backbone.View
  initialize: (options) ->
    @channel = options.channel
    @fragment = @channel.get('fragment')

  events:
    'click .connection' : 'loadConnection'
    'click .preview'    : 'loadEmbed'

  loadConnection: (e) ->
    @target = $(e.currentTarget)

    @deactivateContext()
    @deactivateLinks()

    @target.
      addClass('active').
      parent().
      addClass('active')

  deactivateLinks: ->
    @$('.active').removeClass 'active'


  deactivateContext: ->
    # channel = FP.channels.where({ slug: @target.data('context') })[0]
    # channel.destroy()
    $("##{@target.data('context')}").nextAll().hide()

  loadEmbed: (e) ->
    $target = $(e.currentTarget)
    $embed = $($target.data 'embed')
    $embed.attr('src', "#{$embed.attr('src')}&autoplay=1")
    $target.replaceWith $embed

  render: -> @fragment