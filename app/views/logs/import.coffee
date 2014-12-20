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
      "click .clear": "_empty_collection"

    template: _.template(Template)

    className: "col-md-8 col-md-offset-2"

    # private

    _import_file: (event) ->
      event.preventDefault()

      files = $("#import_file")[0].files
      return @_alert_no_file() unless files.length > 0
      @_read_file(file) for file in files

    _alert_no_file: -> alert("You haven't chosen a file!")

    _read_file: (file) ->
      reader = new FileReader()

      reader.onload = =>
        for line in reader.result.split("\n")
          log = _.object(@_key_value_matches(line))
          continue if _.isEmpty(log)
          log.datetime = line.match(@_datetime_regex)[0]
          @collection.create(log)
        window.location.hash = "logs"

      reader.readAsText(file)

    _key_value_matches: (line) ->
      [match[1], match[2]] while match = @_key_value_regex.exec(line)

    _key_value_regex: /(\w+)=((?!{)\S+|{.+})/g

    _datetime_regex: /((\d+-?){3}T(\d+:?){3})\.\d+/

    _empty_collection: ->
      model.destroy() while model = @collection.first()
      alert("Cleared all Logs")
