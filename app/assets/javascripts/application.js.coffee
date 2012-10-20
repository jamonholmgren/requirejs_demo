require [
  "jquery", 
  "lodash",
  "modules/tasks/tasks"
], ($, _, TaskViewModel) ->

  $ -> 
    viewModel = new TaskViewModel()
    viewModel.bootstrap()