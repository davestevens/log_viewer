define [
  "views/logs/layout",
  "views/logs/import"
], (LogsLayoutView, LogsImportView) ->
  index: -> @view = new LogsLayoutView()

  import: -> @view = new LogsImportView()
