scoped_client = require 'scoped-http-client'
util = require 'util'

class Tousen
  constructor: (@url, @options) ->
    @client = scoped_client.create @url, @options
    @stashes = new Stashes @client

class API
  constructor: (@client) ->
    @async = require 'async'

  get: (path, options, callback) ->
    @client.scope path, (cli) =>
      cli.get() (err, resp, body) =>
        @send_result err, resp, body, options, callback

  post: (path, options, callback) ->
    @client.scope path, (cli) =>
      cli.post(options.payload) (err, resp, body) =>
        @send_result err, resp, body, options, callback

  delete: (path, options, callback) ->
    @client.scope path, (cli) =>
      cli.del() (err, resp, body) =>
        @send_result err, resp, body, options, callback

  send_result: (err, resp, body, options, callback) ->
    if err
      callback(err, body)
    if options.deserialize_response
      try
        res = JSON.parse(body)
      catch e
        err = e
        res = body
     else
       res = body
     callback(err, res)

class Stashes extends API
  constructor: ->
    super

  get_stashes: (options, callback) ->
    @get 'stashes', options, callback

  get_stash: (stash_path, options, callback) ->
    @get "stashes/#{stash_path}", options, callback

  create_stash: (options, callback) ->
    if options.payload?
      try
        options.payload = JSON.stringify(options.payload)
      catch
        callback(err, options.payload)
    @post "stashes", options, callback

  create_stash_path: (path, options, callback) ->
    if options.payload?
      try
        options.payload = JSON.stringify(options.payload)
      catch
        callback(err, options.payload)
    @post "stashes/#{path}", options, callback

  delete_stash_path: (path, options, callback) ->
    @delete "stashes/#{path}", options, callback


module.exports = (url, options) ->
  new Tousen url, options
