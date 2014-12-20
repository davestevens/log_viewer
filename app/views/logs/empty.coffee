define [
  "marionette",
  "text!templates/logs/empty.html"
], (Marionette, Template) ->
  class EmptyLogView extends Marionette.ItemView
    template: _.template(Template)

    tagName: "tr"

    className: "info"
