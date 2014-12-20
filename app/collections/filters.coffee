define ["backbone", "models/filter"],
(Backbone, Filter) ->
  class Filters extends Backbone.Collection
    model: Filter

    webSql: new Backbone.WebSql("filters", Filter)
