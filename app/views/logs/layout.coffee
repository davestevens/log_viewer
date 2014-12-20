define [
  "app",
  "marionette",
  "views/filters/index",
  "views/logs/index",
  "collections/logs",
  "text!templates/logs/layout.html"
], (App, Marionette, FiltersView, LogsView, Logs, Template) ->
  class LogsLayoutView extends Marionette.LayoutView
    initialize: ->
      @listenTo(App.vent, "logs:filter", @render_logs_list)

    template: _.template(Template)

    regions:
      filters: ".filters"
      logs: ".logs"

    onRender: ->
      @render_filters()
      @render_logs_list()

    render_filters: ->
      view = new FiltersView()
      @filters.show(view)

    render_logs_list: (filter) =>
      view = new LogsView(collection: @_filtered_collection(filter))
      @logs.show(view)

    # private

    _filtered_collection: (filter) ->
      logs = new Logs()
      logs.fetch(filter: filter)
      logs
