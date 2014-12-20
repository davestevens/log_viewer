define [
  "marionette",
  "text!templates/logs/log.html"
], (Marionette, Template) ->
  class LogView extends Marionette.ItemView
    template: _.template(Template)

    tagName: "tr"
