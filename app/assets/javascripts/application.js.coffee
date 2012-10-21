require [
  "jquery", 
  "lodash",
  "modules/tasks/tasks"
], ($, _, TasksViewModel) ->

  $ -> 
    $.get "/tasks.json", (tasks) ->
      viewModel = new TasksViewModel(tasks)
      viewModel.setup(".tasks-wrapper")

    $(document).on "keyup", (e) ->
      current_focus = document.activeElement.tagName
      if e.keyCode is 84 and (current_focus isnt "INPUT" and current_focus isnt "TEXTAREA")
        $("[data-class=addTask]").trigger "click"
