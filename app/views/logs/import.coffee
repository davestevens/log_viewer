define [
  "marionette",
  "text!templates/logs/import.html",
  "collections/logs"
], (Marionette, Template, Logs) ->
  class LogsImportView extends Marionette.ItemView
    initialize: ->
      @collection = new Logs()
      @collection.fetch()

    events:
      "submit form": "_import_file"

    template: _.template(Template)

    className: "col-md-8 col-md-offset-2"

    # private

    _import_file: (event) ->
      event.preventDefault()

      file = $("#import_file")[0].files[0]
      return @_alert_no_file() unless file?
      @_read_file(file)

    _alert_no_file: -> alert("You haven't chosen a file!")

    _read_file: (file) ->
      reader = new FileReader()

      reader.onload = =>
        @_empty_collection()
        _(JSON.parse(reader.result)).each((log) =>
          @collection.create(log)
        )
        window.location.hash = "logs"

      reader.readAsText(file)

    _empty_collection: ->
      model.destroy() while model = @collection.first()
