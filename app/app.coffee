define ["marionette", "backbone-dualstorage"], (Marionette) ->
  App = new Marionette.Application()

  App.addRegions(main: ".main")

  App.on("start", -> Backbone.history.start())

  App
