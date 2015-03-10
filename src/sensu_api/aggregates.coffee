SensuAPI = require '../sensu_api.coffee'

# The callbacks to this class' methods should accept two parameters, an error object and the result.
module.exports = class Aggregates extends SensuAPI
  constructor: ->
    super

  # Returns an array of aggregate data from the Sensu API to the callback.
  get_aggregates: ({callback}) ->
    @get path: 'aggregates', callback: callback

  # Requires a check name as "check".
  # Returns an array of aggregate data for a check from the Sensu API to the callback.
  get_aggregates_for_check: ({check, callback}) ->
    @get path: "aggregates/#{check}", callback: callback

  # Requires a check name as "check" and an issues timestamp as "issued".
  # Returns an aggregate object from the Sensu API to the callback.
  get_aggregate: ({check, issued, callback}) ->
    @get path: "aggregates/#{check}/#{issued}", callback: callback
