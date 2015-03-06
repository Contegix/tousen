@API = require './api.coffee'

module.exports = class Stashes extends @API
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
