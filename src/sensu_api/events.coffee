SensuAPI = require '../sensu_api.coffee'

# Provides methods for accessing the events endpoints of the Sensu API
# @see http://sensuapp.org/docs/latest/api_events
#
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
class Events extends SensuAPI
  # See {SensuAPI#constructor}
  constructor: ->
    super

  # Get an array of all event objects from the Sensu API
  #
  # @example Using the Tousen namespace, get an array of all event objects from the Sensu API
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.events.get_events callback: (err, res) ->
  #     events = res
  #
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_events: ({callback}) ->
    @get path: 'events', callback: callback

  # Get an array of all event objects for a client from the Sensu API
  #
  # @example Using the Tousen namespace, get an array of all event objects for the client "test_client" from the Sensu API
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.events.get_events_client client: 'test_client', callback: (err, res) ->
  #     test_client_events = res
  #
  # @param {String} client The name of the client for which to retrieve events
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_events_client: ({client, callback}) ->
    @get path: "events/#{client}", callback: callback

  # Get an object describing all events for a check on a client from the Sensu API
  #
  # @example Using the Tousen namespace, get an object describing all events for check "test_check" on client "test_client" from the Sensu API
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.events.get_events_check check: 'test_check', client: 'test_client', callback: (err, res) ->
  #     test_check_events = res
  #
  # @param {String} check The name of the check for which to retrieve events
  # @param {String} client The name of the client for which to retrieve events
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_events_check: ({client, check, callback}) ->
    @get path: "events/#{client}/#{check}", callback: callback

  # Resolve outstanding events in a non-OK state for a check on a client in the Sensu API
  #
  # @example Using the Tousen namespace, resolve outstanding events for check "test_check" on client "test_client" in the Sensu API
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.events.resolve_event check: 'test_check', client: 'test_client', callback: (err, res) ->
  #     response = res
  #
  # @param {String} check The name of the check for which to resolve events
  # @param {String} client The name of the client for which to resolve events
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  resolve_event: ({client, check, callback}) ->
    @delete path: "events/#{client}/#{check}", callback: callback

  # Resolve oustanding events in a non-OK state for a check on a client by posting an object to the Sensu API
  #
  # @example Using the Tousen namespace, resolve outstanding events for check "test_check" on client "test_client" by posting an object to the Sensu API
  #   data = { client: "test_client", check: "test_check" }
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.events.resolve_event_post data: data, callback: (err, res) ->
  #     response = res
  #
  # @param {Object} data The object defining the client and check to be resolved.
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  resolve_event_post: ({data, callback}) ->
    try
      payload = JSON.stringify(data)
      @post path: "resolve", payload: payload, callback: callback
    catch e
      callback e, payload

module.exports = Events
