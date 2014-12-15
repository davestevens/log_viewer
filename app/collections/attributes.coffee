define ["backbone", "models/attribute"], (Backbone, Attribute) ->
  class Attributes extends Backbone.Collection
    model: Attribute

    url: -> "/attributes"

    local: true

    selections: (ids) -> @filter((model) -> _.contains(ids, model.id))
