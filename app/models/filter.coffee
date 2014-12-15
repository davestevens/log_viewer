define [
  "backbone",
  "collections/attributes"
], (Backbone, Attributes) ->
  class Filter extends Backbone.Model
    defaults:
      exclusive: null
      inclusive: null
      from_date: null
      to_date: null

    url: "/filters"

    local: true

    build: ->
      exclusive: @_build_filters(@get("exclusive"))
      inclusive: @_build_filters(@get("inclusive"))

    parse: (response, _options) ->
      _(response).tap((r) =>
        r.exclusive = @_create_collection("exclusive", r.exclusive)
        r.inclusive = @_create_collection("inclusive", r.inclusive)
      )

    toJSON: ->
      attributes = _.clone(@attributes)
      _(attributes).tap((attrs) ->
        attrs.exclusive = attrs.exclusive.pluck("id")
        attrs.inclusive = attrs.inclusive.pluck("id")
      )

    # private

    _build_filters: (attributes) ->
      _.chain(attributes.where(active: true))
        .map((model) -> [model.get("name"), model.get("value")])
        .object()
        .value()

    _create_collection: (attribute, value) ->
      if @get(attribute) instanceof Backbone.Collection
        @get(attribute)
      else
        attributes = new Attributes()
        attributes.fetch()
        new Attributes(attributes.selections(value))
