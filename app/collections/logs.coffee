define ["backbone", "models/log"],
(Backbone, Log) ->
  class Logs extends Backbone.Collection
    model: Log

    webSql: new Backbone.WebSql("logs", Log)
