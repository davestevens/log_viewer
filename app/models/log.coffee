define ["backbone", "services/backbone.websql"], (Backbone, BackboneWebSql) ->
  class Log extends Backbone.Model
    defaults:
      action: null
      controller: null
      datetime: null
      db: null
      duration: null
      format: null
      method: null
      params: null
      path: null
      remote_ip: null
      server: null
      status: null
      tenant: null
      user_id: null
      view: null

    sync: BackboneWebSql.sync

    webSql: new BackboneWebSql("logs", Log)
