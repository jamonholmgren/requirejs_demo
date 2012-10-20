define ["jquery", "knockout"], ($, ko) ->
  class Task
    constructor: (id, description, complete) ->
      @id          = id
      @description = description
      @complete    = ko.observable(complete)
      
    # View state
    isVisible: ->
      !@complete()

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
                description:  @description,
                complete:     @complete
      hash.task.id = @id if @id
      hash

    updateLocalAttributes: (data) ->
      @id           = data.id
      @description  = data.description
      @complete(data.complete)

    create: ->
      self = this
      $.post "/tasks.json", @hash(), (data) ->
        # self.updateLocalAttributes(data)

    update: ->
      self = this
      hash = @hash()
      hash._method = "PUT"
      $.post "/tasks/#{@id}.json", hash, (data) ->
        # self.updateLocalAttributes(data)

    save: ->
      if @id isnt null
        @update()
      else
        @create()


        
