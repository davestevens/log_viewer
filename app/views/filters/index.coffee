define [
  "app",
  "marionette",
  "collections/filters",
  "views/filters/filter",
  "text!templates/filters/index.html"
], (App, Marionette, Filters, FilterView, Template) ->
  class LayoutsView extends Marionette.CompositeView
    initialize: -> @collection = new Filters()

    onShow: -> @collection.fetch()

    className: "col-md-8 col-md-offset-2"

    template: _.template(Template)

    childView: FilterView

    childViewContainer: ".list"

    events:
      "click .js-add": -> @collection.create({})
      "click .js-apply": -> App.vent.trigger("logs:filter", @_filter_data())

    # private

    _filter_data: ->
      _.chain(@collection.where(active: "true"))
        .map((model) -> [model.get("name"), model.get("value")])
        .object()
        .value()
