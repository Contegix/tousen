SensuAPI = require '../sensu_api.coffee'

# The callbacks to these methods should accept two parameters, an error object and the result.
module.exports = class Stashes extends SensuAPI
  constructor: ->
    super

  # Returns an array of stashes from the Sensu API to the callback.
  get_stashes: ({callback}) ->
    @get path: 'stashes', callback: callback

  # Requires a stash path as "path".
  # Returns the contents of that stash freom the Sensu API to the callback.
  get_stash_path: ({path, callback}) ->
    @get path: "stashes/#{path}", callback: callback

  # Requires a stash definition data object as "data".
  # Serializes the data and posts it to the Sensu API to create a stash.
  # Returns the result of the API call to the callback.
  create_stash: ({data, callback}) ->
    try
      payload = JSON.stringify(data)
      @post path: "stashes", payload: payload, callback: callback
    catch e
      callback e, payload

  # Requires a stash path as "path"
  # Optionally, takes an object defining the stash's contents as "data". 
  # Sends the API request to create a stash at the stash path. 
  # Returns the result of the API call to the callback.
  create_stash_path: ({path, data, callback}) ->
    if data?
      try
        payload = JSON.stringify(data)
      catch e
        callback e, payload
    @post path: "stashes/#{path}", payload: payload, callback: callback

  # Requires a stash path as "path".
  # Sends the API request to delete the stash at the stash path.
  # Returns the result of the API call to the callback.
  delete_stash_path: ({path, callback}) ->
    @delete "stashes/#{path}", options, callback
