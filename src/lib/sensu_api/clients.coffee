SensuAPI = require '../sensu_api.coffee'

# The callbacks to these methods should accept two parameters, an error object and the result.
module.exports = class Clients extends SensuAPI
  constructor: ->
    super

  # Returns an array of all clients from the Sensu API to the callback.
  get_clients: ({callback}) ->
    @get path: 'clients', callback: callback

  # Requires a client name as "client".
  # Returns the client object from the Sensu API to the callback.
  get_client: ({client, callback}) ->
    @get path: "clients/#{client}", callback: callback

  # Requires a client name as "client". 
  # Returns the client's history object from the Sensu API to the callback.
  get_client_history: ({client, callback}) ->
    @get path: "clients/#{client}/history", callback: callback

  # Requires a client name as "client". 
  # Rakes the API call to delete the client. 
  # Returns the result of the API call to the callback.
  delete_client: ({client, callback}) ->
    @delete path: "clients/#{client}", callback: callback
