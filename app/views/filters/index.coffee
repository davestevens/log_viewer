define [
  "app",
  "marionette",
  "views/filters/filter",
  "text!templates/filters/index.html"
], (App, Marionette, FilterView, Template) ->
  class LayoutsView extends Marionette.CompositeView
    className: "col-md-8 col-md-offset-2"

    template: _.template(Template)

    childView: FilterView

    childViewContainer: ".list"

    events:
      "click .js-add": -> @collection.create({})
