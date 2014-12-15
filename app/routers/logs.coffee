define ["app", "marionette", "controllers/logs"],
(App, Marionette, LogsController) ->
  class LogsRouter extends Marionette.AppRouter
    initialize: -> @on("route", @change)

    change: -> App.main.show(@controller.view)

    controller: LogsController

    appRoutes:
      "logs": "index"
      "logs/import": "import"
      "*default": "index"

  App.addInitializer(-> new LogsRouter())

  LogsRouter
