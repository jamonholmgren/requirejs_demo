require [
  "jquery", 
  "lodash",
  "modules/tasks/tasks"
], ($, _, TasksViewModel) ->

  $ -> 
    $.get "/tasks.json", (tasks) ->
      viewModel = new TasksViewModel(tasks)
      viewModel.setup(".tasks-wrapper")
