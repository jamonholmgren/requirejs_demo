require [
  "jquery", 
  "lodash",
  "modules/test/test"
  "knockout", 
  "knockout-classBindingProvider"
], ($, _, Test) ->

  $ -> 
    thing = new Test()
    alert thing.method()