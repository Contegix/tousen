SensuAPI = require './sensu_api.coffee'

# Except where otherwise noted, all methods on this class take
# an options object and callback function as their next to last and last arguments.
# The callbacks to these methods should accept two parameters, an error object and the result.
module.exports = class Events extends SensuAPI
  constructor: ->
    super

  # Takes no additional arguments. Returns an array of event objects from the Sensu API to the callback.
  get_events: (options, callback) ->
    @get 'events', options, callback

  # Additionally, takes a client name as an argument. 
  # Returns the events for that client from the Sensu API to the callback.
  get_events_for_client: (client, options, callback) ->
    @get "events/#{client}", options, callback

  # Additionally, akes a client name and a check name as the first and second arguments.
  # Returns the events for that check on that client from the Sensu API to the callback.
  get_events_check_for_client: (client, check, options, callback) ->
    @get "events/#{client}/#{check}", options, callback

  # Additionally, takes a client name and a check name as the first and second arguments.
  # Makes the API call to resolve the events specified by those parameters.
  # Returns the result from the Sensu API to the callback.
  resolve_event: (client, check, options, callback) ->
    @delete "events/#{client}/#{check}", options, callback

  # Takes no additional arguments, but expects the options object to have a property payload.
  # Serializes options.payload and posts it to the resolve endpoint to resolve an event.
  # Returns the result from the Sensu API to the callback.
  resolve_event_post: (options, callback) ->
    @post "resolve", options, callback
