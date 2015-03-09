SensuAPI = require '../sensu_api.coffee'

# The callbacks to these methods should accept two parameters, an error object and the result.
module.exports = class Checks extends SensuAPI
  constructor: ->
    super

  # Returns an array of all checks from the Sensu API to the callback.
  get_checks: ({callback}) ->
    @get path: 'checks', callback: callback

  # Requires a check name as "check".
  # Returns the check object from the Sensu API to the callback.
  get_check: ({check, callback}) ->
    @get path: "checks/#{check}", callback: callback

  # Requires a check name as "check". and an object containing additional parameters to be posted in the run request as "data".
  # Sends a run request via the Sensu API. 
  # Returns the result of the API call to the callback.
  request_run: ({check, data, callback}) ->
    try
      payload = JSON.stringify(data)
      @post path: "request", payload: payload, callback: callback
    catch e
      callback e, data
