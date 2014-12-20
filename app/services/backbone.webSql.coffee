define [
  "backbone",
  "services/backbone.webSql/database"
  "services/backbone.webSql/sync"
],
(Backbone, BackboneWebSqlDatabase, BackboneWebSqlSync) ->
  class BackboneWebSql
    constructor: (table_name, model) ->
      @table_name = table_name
      @db = new BackboneWebSqlDatabase()
      @db.create_table(@table_name, _.keys(new model().attributes))

    find: (model, options) ->
      sql = "SELECT * FROM #{@table_name} WHERE(id=?)"
      values = [model.id]
      success = (_transaction, results) ->
        if results.rows.length > 0
          model = results.rows.item(0)
          options.success(model)
        else
          options.success({})
      error = ->
        console.error "find", arguments
        options.error()
      @db.execute(sql, values, success, error)

    all: (options) ->
      values = []
      sql = "SELECT * FROM #{@table_name}"
      if options.filter && !_.isEmpty(options.filter)
        sql += " WHERE " + _(options.filter).map((value, key) ->
          values.push(value)
          "#{key}=?"
        ).join(" AND ")
      sql += " ORDER BY #{options.order}" if options.order
      sql += " LIMIT #{options.limit}" if options.limit
      sql += " OFFSET #{options.offset}" if options.offset
      success = (_transaction, results) ->
        models = []
        models.push(results.rows.item(i)) for i in [0...results.rows.length]
        options.success(models)
      error = ->
        console.error "all", arguments
        options.error()
      @db.execute(sql, values, success, error)

    create: (model, options) ->
      [keys, values, placeholder] = @_prepare_insert(model.attributes)
      sql = "INSERT INTO #{@table_name} (#{keys}) VALUES (#{placeholder})"
      success = (_transation, results) ->
        model.set("id", results.insertId)
        options.success(model.attributes)
      error = ->
        console.error "create", arguments
        options.error()
      @db.execute(sql, values, success, error)

    update: (model, options) ->
      values = []
      a = _(model.toJSON()).map( (value, key) ->
        values.push(value)
        "#{key}=?"
      )
      sql = "UPDATE #{@table_name} SET #{a} WHERE(id=?)"
      values.push(model.id)
      success = (_transaction, results) -> options.success(model.attributes)
      error = ->
        console.error "update", arguments
        options.error()
      @db.execute(sql, values, success, error)

    delete: (model, options) ->
      sql = "DELETE FROM #{@table_name} WHERE(id=?)"
      values = [model.id]
      success = (_transaction, results) ->
        if results.rowsAffected > 0
          options.success(model.attributes)
        else
          options.error(model.attributes)
      error = ->
        console.error "delete", arguments
        options.error()
      @db.execute(sql, values, success, error)

    _prepare_insert: (data = {}) ->
      keys = []; values = []
      for key, value of data
        keys.push(key); values.push(value)
      placeholder = _.range(values.length).map(-> "?").join(",")
      [keys.join(","), values, placeholder]

  BackboneWebSql.sync = BackboneWebSqlSync

  Backbone.WebSql = BackboneWebSql
  Backbone.sync = BackboneWebSql.sync

  BackboneWebSql
