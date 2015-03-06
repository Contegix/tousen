SensuAPI = require './sensu_api.coffee'

module.exports = class Events extends SensuAPI
  constructor: ->
    super

  get_events: (options, callback) ->
    @get 'events', options, callback

  get_events_for_client: (client, options, callback) ->
    @get "events/#{client}", options, callback

  get_events_check_for_client: (client, check, options, callback) ->
    @get "events/#{client}/#{check}", options, callback

  resolve_event: (client, check, options, callback) ->
    @delete "events/#{client}/#{check}", options, callback

  resolve_event_post: (options, callback) ->
    @post "resolve", options, callback
