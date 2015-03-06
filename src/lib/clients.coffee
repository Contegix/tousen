SensuAPI = require './sensu_api.coffee'

# Except where otherwise noted, all methods on this class take
# an options object and callback function as their next to last and last arguments.
# The callbacks to these methods should accept two parameters, an error object and the result.
module.exports = class Clients extends SensuAPI
  constructor: ->
    super

  # Takes no additional arguments, returns an array of all clients from the Sensu API to the callback.
  get_clients: (options, callback) ->
    @get 'clients', options, callback

  # Additionally, takes a client name as an argument, returns the client object from the Sensu API to the callback.
  get_client: (client, options, callback) ->
    @get "clients/#{client}", options, callback

  # Additionally, takes a client name, returns the client's history object from the Sensu API to the callback.
  get_client_history: (client, options, callback) ->
    @get "clients/#{client}/history", options, callback

  # Additionally, takes a client name, makes the API call to delete the client. 
  # Returns the result of the API call to the callback.
  delete_client: (client, options, callback) ->
    @delete "clients/#{client}", options, callback
