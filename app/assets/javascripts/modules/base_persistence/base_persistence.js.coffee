define ["jquery", "lodash"], ($, _) ->
  
  # Base Persistence Class
  # Handles saving objects to the app's API.
  # Requires the following methods to be defined on any inheriting object:
  #   - baseUrl: where to post to
  #   - updateLocalAttributes(): how to handle the data returned from saving
  #   - hash(): a method to convert the object into a hash that can be saved
  #     via ajax.
  class BasePersistence
    persisted: ->
      @id() isnt null

    create: ->
      self = this
      $.post "#{@baseUrl}.json", @hash(), (data) ->
        self.updateLocalAttributes(data)

    update: ->
      self = this
      hash = @hash()
      hash._method = "PUT"
      $.post "#{@baseUrl}/#{@id()}.json", hash, (data) ->
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
        $.post "#{@baseUrl}/#{@id()}.json", hash
      delete this
