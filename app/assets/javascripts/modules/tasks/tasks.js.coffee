define [
  "jquery",
  "lodash",
  "./models/task",
  "text!./templates/tasks.html",
  "knockout",
  "knockout-classBindingProvider"
], ($, _, Task, view, ko, BindingProvider) ->

  class TaskViewModel
    constructor: ->
      $.get "/tasks.json", (raw_tasks) ->
        tasks = _.map raw_tasks, (task) -> new Task(task.id, task.description, task.completed)
        @tasks = ko.observableArray(tasks)
    bindings:
      items: (context, classes) ->
        { foreach: @tasks }
    bootstrap: ->
      $("body").append(view)
      ko.bindingProvider.instance = new BindingProvider(@bindings)
      ko.applyBindings()