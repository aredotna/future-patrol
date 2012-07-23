class FP.Collections.Channels extends Backbone.Collection
  model: FP.Models.Channel

  comparator: (model) -> model.get 'position'

  isInCollection: (slug) -> _.include(@pluck('slug'), slug)

  isRendered: (slug) -> $("##{slug}").length > 0

  isPresent: (slug) -> @isInCollection(slug) or @isRendered(slug)

  _add: (channel) ->
    unless @isInCollection(channel.get('slug'))
      if channel.get('slug') is FP.source
        @unshift(channel)
      else
        @push(channel)

      channel.setFragment()
      channel.set { position: @length }

  insert: (channel) ->
    unless @isPresent(channel.get('slug'))
      console.log("#{channel.get('slug')} is not present")

      @_add(channel)
      $.when(channel.fetch()).then =>
        @trigger('render:channel', channel)

    else
      console.log("#{channel.get('slug')} is present")

      @_add(channel)
      @trigger('move:channel', channel)