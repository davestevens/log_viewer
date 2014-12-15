define [
  "marionette",
  "text!templates/attributes/attribute.html"
], (Marionette, Template) ->
  class AttributeView extends Marionette.ItemView
    template: _.template(Template)

    events:
      "keyup input:text": "update_attribute"
      "change input:checkbox": "update_checkbox"
      "click .js-remove": -> @model.destroy()

    onShow: -> @$el.find(".name").focus()

    update_attribute: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.value
      @model.save(options)

    update_checkbox: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.checked
      @model.save(options)
