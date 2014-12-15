requirejs.config
  baseUrl: "app"
  paths:
    backbone: "../bower_components/backbone/backbone"
    "backbone-dualstorage": "../bower_components/backbone.dualStorage/backbone.dualstorage"
    bootstrap: "../bower_components/bootstrap/dist/js/bootstrap"
    marionette: "../bower_components/marionette/lib/backbone.marionette"
    jquery: "../bower_components/jquery/dist/jquery"
    text: "../bower_components/requirejs-text/text"
    underscore: "../bower_components/underscore/underscore"

  shim:
    backbone: ["underscore"]
    "backbone-dualstorage": ["backbone"]
    bootstrap: ["jquery"]
    marionette: ["backbone"]

define ["app", "routers/logs", "bootstrap"], (App) ->
  App.start()
