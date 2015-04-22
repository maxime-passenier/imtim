# tha config
requirejs.config
  paths:
    underscore: "underscore-min"
    jquery: "//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min"

# start the app
require [
  'helper/utils',
  'pageMapping',
  'jquery'
], (utils, pageMapping)->
  pageMapping.load()