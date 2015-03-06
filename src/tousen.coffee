class Tousen
  constructor: (@url, @options) ->
    http_client = require 'scoped-http-client'
    @client = http_client.create @url, @options
    Stashes = require './lib/stashes.coffee'
    @stashes = new Stashes @client

module.exports = (url, options) ->
  new Tousen url, options
