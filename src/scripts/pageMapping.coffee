define [
  'jquery'
  'underscore'
  'pages/premises'
], (jquery, _, premises)->

  maps =
    "com_properties": premises

  load = ->
    jquery(window).load ->
      n_body = jquery('body')
      _.each maps, (value, name)->
        #console.log 'n_body', n_body.hasClass
        if n_body.hasClass(name) and value.load?
          value.load()

  load: load