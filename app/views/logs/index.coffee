define [
  "app",
  "marionette",
  "views/logs/log",
  "views/logs/empty",
  "text!templates/logs/index.html"
], (App, Marionette, LogView, EmptyLogView, Template) ->
  class LogsView extends Marionette.CompositeView
    childView: LogView

    emptyView: EmptyLogView

    childViewContainer: "tbody"

    template: _.template(Template)

    events:
      "click .load_more": -> App.vent.trigger("logs:more")
