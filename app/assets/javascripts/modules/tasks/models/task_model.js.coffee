define ["jquery", "knockout"], ($, ko) ->
  class Task
    constructor: (id, description, complete) ->
      @id          = ko.observable(id)
      @description = ko.observable(description)
      @complete    = ko.observable(complete)
      @isEditing   = ko.observable(false)

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

    persisted: ->
      @id() isnt null

    updateLocalAttributes: (data) ->
      @id(data.id)
      @description(data.description)
      @complete(data.complete)

    create: ->
      self = this
      $.post "/tasks.json", @hash(), (data) ->
        self.updateLocalAttributes(data)

    update: ->
      self = this
      hash = @hash()
      hash._method = "PUT"
      $.post "/tasks/#{@id()}.json", hash, (data) ->
        self.updateLocalAttributes(data)

    save: ->
      if @persisted()
        @update()
      else
        @create()

    destroy: ->
      if @persisted()
        hash = @hash()
        hash._method = "DELETE"
        $.post "/tasks/#{@id()}.json", hash
      delete this

        
