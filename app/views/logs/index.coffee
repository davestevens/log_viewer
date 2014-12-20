define [
  "app",
  "marionette",
  "views/filter/show",
  "views/logs/list",
  "text!templates/logs/index.html"
], (App, Marionette, FilterView, LogsListView, Template) ->
  class LogsView extends Marionette.LayoutView
    initialize: ->
      @listenTo(App.vent, "logs:filter", @render_logs_list)

    template: _.template(Template)

    regions:
      filter: ".filter"
      logs: ".logs"

    onRender: ->
      @render_filter()
      @render_logs_list()

    render_filter: ->
      view = new FilterView()
      @filter.show(view)

    render_logs_list: (filter) =>
      view = new LogsListView(collection: @_filtered_collection(filter))
      view = new LogsListView(collection: @_filtered_collection(filter))
      @logs.show(view)

    # private
    _filtered_collection: (filter) ->
      return @collection unless filter
      @collection.filter(filter)
