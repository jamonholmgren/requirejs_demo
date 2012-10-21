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
        foreach: @tasks

      taskDescription: ->
        text: @description
        attr: 
          for: "task-#{@id}"
          class: "complete" if @complete()
        visible: !@isEditing()

      editTaskDescription: ->
        value: @description
        visible: @isEditing()
        valueUpdate: "afterkeypress"
        event:
          keypress: (data, event) ->
            if event.which is 13
              @save()
              @stopEditing()
              $("[data-class=addTask]").trigger "click"
            true

      removeTask: (context, classes) ->
        click: ->
          @destroy()
          context.$root.removeTask(this)
        visible: @persisted()

      editTask: ->
        click: @startEditing,
        visible: !@isEditing()

      cancelEditTask: (context, classes) ->
        click: -> 
          @stopEditing()
          if !@persisted() or @description().length is 0
            context.$root.removeTask(this)
        visible: @isEditing()

      saveTask: ->
        click: ->
          @save()
          @stopEditing()
        visible: @isEditing()

      addTask: ->
        click: ->
          task = @addTask(null)
          task.startEditing()
          $("[data-class=editTaskDescription]:visible").focus()

      taskCheckbox: ->
        click:    @toggleTaskCompleted,
        checked:  @complete(),
        attr: { id: "task-#{@id}" }
    
    addTask: (description) ->
      task = new Task(null, description, false)
      @tasks.push(task)
      task

    removeTask: (task) ->
      @tasks.remove(task)
    
    addRandomTask: ->
      @addTask("Some task")
    
    bootstrap: (custom_selector) ->
      selector = custom_selector || "body"

      $(selector).append(view)
      ko.bindingProvider.instance = new BindingProvider(@bindings)
      ko.applyBindings(this, document.getElementById("tasks"))