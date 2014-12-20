define [
  "app",
  "marionette",
  "views/filters/index",
  "collections/filters",
  "views/logs/index",
  "collections/logs",
  "text!templates/logs/layout.html"
], (App, Marionette, FiltersView, Filters, LogsView, Logs, Template) ->
  class LogsLayoutView extends Marionette.LayoutView
    initialize: ->
      @filters = new Filters()
      @logs = new Logs()
      @page_size = 20
      @page = 1

      @listenTo(App.vent, "logs:more", =>
        @logs.fetch(_.extend(@_fetch_options(), remove: false))
        @page++
      )
      @listenTo(@filters, "sync", (filters) =>
        @page = 0
        @logs.fetch(@_fetch_options())
        @page++
      )

    template: _.template(Template)

    regions:
      filters_region: ".filters"
      logs_region: ".logs"

    onRender: ->
      @render_filters()
      @render_logs_list()

    render_filters: ->
      @filters.fetch()
      view = new FiltersView(collection: @filters)
      @filters_region.show(view)

    render_logs_list: ->
      view = new LogsView(collection: @logs)
      @logs_region.show(view)

    # private

    _fetch_options: ->
      filter: @filters.build()
      limit: @page_size
      offset: @page_size * @page
      order: "datetime ASC"
