define ["backbone"], (Backbone) ->
  BackboneWebSqlSync = (method, model, options) ->
    store = _.result(model, "webSql") || _.result(model.collection, "webSql")

    switch(method)
      when "read"
        if model.id? then store.find(model, options) else store.all(options)
      when "create" then store.create(model, options)
      when "update" then store.update(model, options)
      when "delete" then store.delete(model, options)
