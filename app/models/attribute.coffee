define ["backbone"], (Backbone) ->
  class Attribute extends Backbone.Model
    defaults:
      name: null
      value: null
      active: true
