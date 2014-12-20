define ["backbone"], (Backbone) ->
  class Filter extends Backbone.Model
    defaults:
      active: true
      name: null
      value: null

    webSql: new Backbone.WebSql("filters", Filter)
