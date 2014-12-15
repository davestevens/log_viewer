define ["backbone"], (Backbone) ->
  class Log extends Backbone.Model
    defaults:
      action: null
      controller: null
      datetime: null
      db: null
      duration: null
      method: null
      params: null
      path: null
      remote_ip: null
      server: null
      status: null
      tenant: null
      user_id: null
      view: null
