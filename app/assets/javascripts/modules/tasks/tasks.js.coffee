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
      taskDescription: ->
        text: @description,
        attr: 
          for: "task-#{@id}"
      addTask: ->
        { click: @addRandomTask }
      taskCheckbox: (context, classes) ->
        click:    @toggleTaskCompleted,
        checked:  @complete(),
        attr:
          id: "task-#{@id}"
    
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