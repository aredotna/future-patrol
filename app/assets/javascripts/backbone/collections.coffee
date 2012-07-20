class FP.Collections.Channels extends Backbone.Collection
  model: FP.Models.Channel

  comparator: (model) -> model.get 'position'