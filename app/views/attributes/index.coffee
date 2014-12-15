define [
  "marionette",
  "views/attributes/attribute",
  "text!templates/attributes/index.html"
], (Marionette, AttributeView, Template) ->
  class AttributesView extends Marionette.CompositeView
    template: _.template(Template)

    childView: AttributeView

    childViewContainer: ".list"

    events:
      "click .js-add": -> @collection.create({})

    collectionEvents:
      "sync": -> @model.trigger("change")
