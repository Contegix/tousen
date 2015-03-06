class Tousen
  Stashes = require './lib/stashes.coffee'
  Clients = require './lib/clients.coffee'
  Checks = require './lib/checks.coffee'
  http_client = require 'scoped-http-client'

  constructor: (url, options) ->
    client = http_client.create url, options
    # Set the global timeout in milliseconds for HTTP requests
    # to options.timeout if it exists, otherwise 5000 ms.
    timeout_ms = if options? and options.timeout? then timeout = options.timeout? else 5000
    if options?
      # If options are set, set the auth header. Sensu's okay with it 
      # being blank if user and/or path are not specified and authentication is not turned on.
      auth = 'Basic ' + new Buffer(options.user + ':' + options.pass).toString('base64')
    else
      auth = ""
    client.headers Authorization: auth, Accept: 'application/json'
    client.timeout(timeout_ms)
    @stashes = new Stashes client
    @clients = new Clients client
    @checks = new Checks client

module.exports = (url, options) ->
  new Tousen url, options
