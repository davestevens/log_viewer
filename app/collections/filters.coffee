define ["backbone", "models/filter"],
(Backbone, Filter) ->
  class Filters extends Backbone.Collection
    model: Filter

    webSql: new Backbone.WebSql("filters", Filter)

    build: ->
      _.chain(@where(active: "true"))
        .map((model) -> [model.get("name"), model.get("value")])
        .object()
        .value()
