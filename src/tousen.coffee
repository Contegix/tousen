# Top level namespace for Tousen. Requires scoped-http-client.
#
# Tousen implements an async wrapper for the Sensu API written in CoffeeScript. 
# API endpoint methods are exposed via the instances of Sensu API clients bound to its properties.
#
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
#
module.exports = class Tousen
  Stashes = require './lib/sensu_api/stashes.coffee'
  Clients = require './lib/sensu_api/clients.coffee'
  Checks = require './lib/sensu_api/checks.coffee'
  Events = require './lib/sensu_api/events.coffee'
  Aggregates = require './lib/sensu_api/aggregates.coffee'
  http_client = require 'scoped-http-client'

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
