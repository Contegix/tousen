SensuAPI = require './sensu_api.coffee'

module.exports = class Checks extends SensuAPI
  constructor: ->
    super

  get_checks: (options, callback) ->
    @get 'checks', options, callback

  get_check: (check, options, callback) ->
    @get "checks/#{check}", options, callback

  request_run: (check, options, callback) ->
    if options.payload?
      try
        options.payload = JSON.stringify(options.payload)
        @post "request", options, callback
      catch e
        callback e, options.payload
