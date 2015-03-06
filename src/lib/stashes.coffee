SensuAPI = require './sensu_api.coffee'

module.exports = class Stashes extends SensuAPI
  constructor: ->
    super

  get_stashes: (options, callback) ->
    @get 'stashes', options, callback

  get_stash_path: (stash_path, options, callback) ->
    @get "stashes/#{stash_path}", options, callback

  create_stash: (options, callback) ->
    if options.payload?
      try
        options.payload = JSON.stringify(options.payload)
        @post "stashes", options, callback
      catch e
        callback e, options.payload

  create_stash_path: (path, options, callback) ->
    if options.payload?
      try
        options.payload = JSON.stringify(options.payload)
        @post "stashes/#{path}", options, callback
      catch e
        callback e, options.payload

  delete_stash_path: (path, options, callback) ->
    @delete "stashes/#{path}", options, callback
