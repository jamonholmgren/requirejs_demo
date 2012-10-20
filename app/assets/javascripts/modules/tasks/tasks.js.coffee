define [
  "jquery",
  "lodash",
  "./models/task",
  "text!./templates/tasks.html",
  "knockout",
  "knockout-classBindingProvider"
], ($, _, Task, view, ko, BindingProvider) ->

  class TasksViewModel
    constructor: (raw_tasks) ->
      tasks = _.map raw_tasks, (t) -> new Task(t.id, t.description, t.complete)
      @tasks = ko.observableArray(tasks)

    bindings:
      items: ->
        { foreach: @tasks }
      description: ->
        { text: @description }
      addTask: ->
        { click: @addRandomTask }
      taskCheckbox: (context, classes) ->
        { 
          click:    @toggleTaskCompleted,
          checked:  @isComplete()
        }
    
    addTask: (description) ->
      task = new Task(null, description, false)
      task.save()
      @tasks.push(task)
    
    addRandomTask: ->
      @addTask("Some task")
    
    bootstrap: ->
      $("body").append(view)
      ko.bindingProvider.instance = new BindingProvider(@bindings)
      ko.applyBindings(this)