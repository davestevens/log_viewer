define [
  "app",
  "marionette",
  "models/filter",
  "views/attributes/index",
  "text!templates/filter/show.html"
], (App, Marionette, Filter, AttributesView, Template) ->
  class FilterView extends Marionette.LayoutView
    template: _.template(Template)

    className: "col-md-8 col-md-offset-2"

    regions:
      inclusive: ".inclusive"
      exclusive: ".exclusive"

    initialize: ->
      @model = new Filter(id: 1)
      @model.fetch()

    events:
      "click .js-apply": "_filter_collection"

    modelEvents:
      "change": -> @model.save()

    onRender: ->
      @render_inclusive_filters()
      @render_exclusive_filters()

    render_inclusive_filters: ->
      view = new AttributesView
        collection: @model.get("inclusive")
        model: @model
      @inclusive.show(view)

    render_exclusive_filters: ->
      view = new AttributesView
        collection: @model.get("exclusive")
        model: @model
      @exclusive.show(view)

    # private

    _filter_collection: ->
      App.vent.trigger("logs:filter", @model.build())
