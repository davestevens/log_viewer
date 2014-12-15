define [
  "collections/logs",
  "views/logs/index",
  "views/logs/import"
], (Logs, LogsView, LogsImportView) ->
  index: ->
    logs = new Logs()
    logs.fetch()
    @view = new LogsView(collection: logs)

  import: -> @view = new LogsImportView()
