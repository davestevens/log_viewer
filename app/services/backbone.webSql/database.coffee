define ->
  class WebSqlDatabase
    constructor: (name = "backboneWebSql",
                  version = "1.0",
                  description = "Backbone WebSql Database",
                  size = @_size) ->
      unless window.openDatabase?
        throw new Error("WebSQL is not supported in your browser")

      @db = window.openDatabase(name, version, description, size)

    execute: (sql, values, success, error) ->
      console.log "execute", sql, values
      @db.transaction( (tx) ->
        tx.executeSql(sql, values, success, error)
      )

    create_table: (name, attributes, success, error) ->
      columns = @_build_columns(attributes)
      sql = "CREATE TABLE IF NOT EXISTS #{name} (#{columns})"
      @execute(sql, null, success, error)

    # private

    _size: (2 * 1024 * 1024)

    _build_columns: (attributes) ->
      ["id INTEGER PRIMARY KEY"].concat(attributes).join(", ")
