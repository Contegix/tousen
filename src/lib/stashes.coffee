SensuAPI = require './sensu_api.coffee'

# Except where otherwise noted, all methods on this class take
# an options object and callback function as their next to last and last arguments.
# The callbacks to these methods should accept two parameters, an error object and the result.
module.exports = class Stashes extends SensuAPI
  constructor: ->
    super

  # Takes no additional arguments.
  # Returns an array of stashes from the Sensu API to the callback.
  get_stashes: (options, callback) ->
    @get 'stashes', options, callback

  # Takes a stash path as the first argument.
  # Returns the contents of that stash freom the Sensu API to the callback.
  get_stash_path: (stash_path, options, callback) ->
    @get "stashes/#{stash_path}", options, callback

  # Takes no additional arguments. The options object is expected to have a payload property.
  # Serializes the payload and posts it to the Sensu API to create a stash.
  # Returns the result of the API call to the callback.
  create_stash: (options, callback) ->
    if options.payload?
      try
        options.payload = JSON.stringify(options.payload)
        @post "stashes", options, callback
      catch e
        callback e, options.payload

  # Takes a stash path as the first argument.
  # The options object may have a payload property.
  # Sends the API request to create a stash at the stash path. 
  # If options.payload is provided, serializes it and sets the stash's content to its value.
  # Returns the result of the API call to the callback.
  create_stash_path: (path, options, callback) ->
    if options.payload?
      try
        options.payload = JSON.stringify(options.payload)
        @post "stashes/#{path}", options, callback
      catch e
        callback e, options.payload

  # Takes a stash path as the first argument.
  # Sends the API request to delete the stash at the stash path.
  # Returns the result of the API call to the callback.
  delete_stash_path: (path, options, callback) ->
    @delete "stashes/#{path}", options, callback
