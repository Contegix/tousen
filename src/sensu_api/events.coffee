SensuAPI = require '../sensu_api.coffee'

# The callbacks to these methods should accept two parameters, an error object and the result.
module.exports = class Events extends SensuAPI
  constructor: ->
    super

  # Returns an array of event objects from the Sensu API to the callback.
  get_events: ({callback}) ->
    @get path: 'events', callback: callback

  # Requires a client name as "client".
  # Returns the events for that client from the Sensu API to the callback.
  get_events_for_client: ({client, callback}) ->
    @get path: "events/#{client}", callback: callback

  # Requires a client name as "client" and a check name as "check".
  # Returns the events for that check on that client from the Sensu API to the callback.
  get_events_for_check: ({client, check, callback}) ->
    @get path: "events/#{client}/#{check}", callback: callback

  # Requires a client name as "client" and a check name as "check".
  # Makes the API call to resolve the events specified by those parameters.
  # Returns the result from the Sensu API to the callback.
  resolve_event: ({client, check, callback}) ->
    @delete path: "events/#{client}/#{check}", callback: callback

  # Takes an object defining events to be resolved as "data"
  # Posts the data to the resolve endpoint to resolve an event.
  # Returns the result from the Sensu API to the callback.
  resolve_events: ({data, callback}) ->
    try
      payload = JSON.stringify(data)
      @post path: "resolve", payload: payload, callback: callback
    catch e
      callback e, payload
