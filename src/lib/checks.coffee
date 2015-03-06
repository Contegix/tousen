SensuAPI = require './sensu_api.coffee'

# Except where otherwise noted, all methods on this class take 
# an options object and callback function as their next to last and last arguments.
# The callbacks to these methods should accept two parameters, an error object and the result.
module.exports = class Checks extends SensuAPI
  constructor: ->
    super

  # Takes no additional arguments, returns an array of all checks from the Sensu API to the callback.
  get_checks: (options, callback) ->
    @get 'checks', options, callback

  # Additonally, takes a check name, returns the check object from the Sensu API to the callback.
  get_check: (check, options, callback) ->
    @get "checks/#{check}", options, callback

  # Additionally, takes a check name, sends a run request via the Sensu API. Returns the result of the API call to the callback.
  request_run: (check, options, callback) ->
    if options.payload?
      try
        options.payload = JSON.stringify(options.payload)
        @post "request", options, callback
      catch e
        callback e, options.payload
