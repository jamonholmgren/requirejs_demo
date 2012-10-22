define ["jquery", "knockout", "base_persistence"], ($, ko, BasePersistence) ->

  class Task extends BasePersistence
    constructor: (id, description, complete) ->
      @id          = ko.observable(id)
      @description = ko.observable(description)
      @complete    = ko.observable(complete)
      @isEditing   = ko.observable(false)
      @baseUrl     = "/tasks"

    # View state
    startEditing: ->
      @isEditing(true)

    stopEditing: ->
      @isEditing(false)

    # Data manipulation
    toggleTaskCompleted: ->
      if @complete() is true
        @complete(false)
      else
        @complete(true)

      if @update()
        true
      else
        false

    # Persistence
    hash: ->
      hash  = task:
                description:  @description(),
                complete:     @complete()
      hash.task.id = @id() if @persisted()
      hash

    updateLocalAttributes: (data) ->
      @id(data.id)
      @description(data.description)
      @complete(data.complete)

        
