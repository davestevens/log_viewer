define [
  "marionette",
  "views/logs/log",
  "views/logs/empty",
  "text!templates/logs/index.html"
], (Marionette, LogView, EmptyLogView, Template) ->
  class LogsView extends Marionette.CompositeView
    childView: LogView

    emptyView: EmptyLogView

    childViewContainer: "tbody"

    template: _.template(Template)
