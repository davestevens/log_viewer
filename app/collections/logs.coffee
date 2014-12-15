define ["backbone", "models/log"], (Backbone, Log) ->
  class Logs extends Backbone.Collection
    model: Log

    url: "/logs"

    comparator: (model) ->
      if model.get("datetime") instanceof Date
        model.get("datetime").getTime()

    local: true

    filter: (filters) ->
      models = _.filter(_.clone(@models), (model) => @_filters(model, filters))
      new Logs(models)

    parse: (response, _options) ->
      _(response).tap((r) ->
        _(r).map((log) -> log.datetime = new Date(log.datetime))
      )

    # private

    _filters: (model, filters) ->
      i = @_inclusive_filter(model, filters.inclusive)
      e = @_exclusive_filter(model, filters.exclusive)
      i && e

    _exclusive_filter: (model, filter) ->
      return true if _.isEmpty(filter)
      @_all(model.get(key) == value for key, value of filter)

    _inclusive_filter: (model, filter) ->
      return true if _.isEmpty(filter)
      @_any(model.get(key) == value for key, value of filter)

    _all: (array) ->
      _.every(array, (element) -> element == true)

    _any: (array) ->
      _.some(array, (element) -> element == true)
