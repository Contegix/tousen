module.exports = class Tousen
  Stashes = require './lib/sensu_api/stashes.coffee'
  Clients = require './lib/sensu_api/clients.coffee'
  Checks = require './lib/sensu_api/checks.coffee'
  Events = require './lib/sensu_api/events.coffee'
  http_client = require 'scoped-http-client'

  constructor: ({url, output_json, user, pass, timeout}) ->
    client = http_client.create url
    # Set the global timeout in milliseconds for HTTP requests
    # to options.timeout if it exists, otherwise 5000 ms.
    timeout_ms = if timeout? then timeout else 5000
    # If user and pass are set, set the auth header. The Sensu API will accept it
    # being blank if user and/or path are not specified and authentication is not turned on.
    if user? and pass?
      auth = 'Basic ' + new Buffer(user + ':' + pass).toString('base64')
    else
      auth = ""
    client.headers Authorization: auth, Accept: 'application/json'
    client.timeout(timeout_ms)
    @stashes = new Stashes client: client, output_json: output_json
    @clients = new Clients client: client, output_json: output_json
    @checks = new Checks client: client, output_json: output_json
    @events = new Events client: client, output_json: output_json
