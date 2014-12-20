define [
  "marionette",
  "views/logs/log",
  "views/logs/empty",
  "text!templates/logs/list.html"
], (Marionette, LogView, EmptyLogView, Template) ->
  class LogsListView extends Marionette.CompositeView
    childView: LogView

    emptyView: EmptyLogView

    childViewContainer: "tbody"

    template: _.template(Template)
