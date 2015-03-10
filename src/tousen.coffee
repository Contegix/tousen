# Tousen implements an async wrapper for the Sensu API written in CoffeeScript. 
# API endpoint methods are exposed via the instances of Sensu API clients bound to its properties. Methods which combine data from multiple API methods are implemented in this class.
# 
# See the following classes for API endpoints exposed by properties on this class: 
#
# - {Aggregates} 
# - {Checks} 
# - {Clients} 
# - {Events} 
# - {Info}
# - {Stashes} 
#
# Dependencies:
#
#  - scoped-http-client
#  - deasync
#
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
module.exports = class Tousen
  Stashes = require './sensu_api/stashes'
  Clients = require './sensu_api/clients'
  Checks = require './sensu_api/checks'
  Events = require './sensu_api/events'
  Aggregates = require './sensu_api/aggregates'
  Info = require './sensu_api/info'
  http_client = require 'scoped-http-client'
  deasync = require 'deasync'

  # Construct a new instance of a Sensu API client
  #
  # @example Construct a new API client configured to talk to http://sensu.example.com:4567/ with user 'foo' and password 'bar'
  #   new Tousen(url: 'http://sensu.example.com:4567/, user: 'foo', pass: 'bar')
  #
  # @param {String} url Required. URL of a Sensu API HTTP endpoint.
  # @param {Boolean} output_json Optional. If set to true, API methods return the raw result JSON rather than deserialized objects.
  # @param {String} user Optional. User for Sensu API authentication.
  # @param {String} pass Optional. Password for Sensu API authentication.
  # @param {Integer} timeout Optional. Timeout for all HTTP requests in milliseconds. Defaults to 5000.
  constructor: ({url, output_json, user, pass, timeout}) ->
    client = http_client.create url
    # If user and pass are set, set the auth header. The Sensu API will accept it
    # being blank if user and/or path are not specified and authentication is not turned on.
    if user? and pass?
      auth = 'Basic ' + new Buffer(user + ':' + pass).toString('base64')
    else
      auth = ""
    client.headers Authorization: auth, Accept: 'application/json'
    client.timeout if timeout? then timeout else 5000
    @stashes = new Stashes client: client, output_json: output_json
    @clients = new Clients client: client, output_json: output_json
    @checks = new Checks client: client, output_json: output_json
    @events = new Events client: client, output_json: output_json
    @aggregates = new Aggregates client: client, output_json: output_json
    @info = new Info client: client, output_json: output_json

  # Get an array of all event objects from the Sensu API with additional parameters added to indicate whether silence stashes exist for the check or client. 
  #
  # - If a stash exists for the check, ```event.check.silenced``` will be ```true```. 
  # - If a stash exists for the client, ```event.client.silenced``` will be ```true```.
  # - If either ```event.client.silenced``` or ```event.check.silenced``` are ```true```, ```event.silenced``` will be true.
  #
  # @example Get an array of all event objects with additional parameters indicating silence status
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.get_events_silence_status callback (err, res) ->
  #     events = res
  #
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_events_silence_status: ({callback}) ->
    stashes_err = stashes = events_err = events = stashes_done = events_done = null
    @stashes.get_stashes callback: (err, res) =>
      stashes_err = err
      stashes = res
      stashes_done = true
    @events.get_events callback: (err, res) =>
      events_err = err
      events = res
      events_done = true
    # Wait until both of the callbacks are called
    deasync.sleep(100) until events_done? and stashes_done?
    if stashes_err?
      callback stashes_err
    else if events_err?
      callback events_err
    else
      stash_paths = stashes.map (stash) ->
        return stash.path
      for e,i in events
        if "silence/#{e.client.name}/#{e.check.name}" in stash_paths
          events[i].check['silenced'] = true
        else
          events[i].check['silenced'] = false
        if "silence/#{e.client.name}" in stash_paths
          events[i].client['silenced'] = true
        else
          events[i].client['silenced'] = false
        if events[i].client['silenced'] or events[i].check['silenced']
          events[i]['silenced'] = true
    callback null, events
