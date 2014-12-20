define [
  "marionette",
  "text!templates/filters/filter.html"
], (Marionette, Template) ->
  class FilterView extends Marionette.ItemView
    template: _.template(Template)

    events:
      "keyup input:text": "update_attribute"
      "change input:checkbox": "update_checkbox"
      "click .js-remove": -> @model.destroy()

    onShow: -> @$el.find(".name").focus()

    templateHelpers: ->
      is_checked: -> @active == "true"

    update_attribute: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.value.toString()
      @model.save(options)

    update_checkbox: (event) ->
      options = {}
      options[event.target.dataset.attribute] = event.target.checked.toString()
      @model.save(options)
