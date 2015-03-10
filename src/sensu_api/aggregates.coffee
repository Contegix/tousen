SensuAPI = require '../sensu_api.coffee'

# Provides functions for accessing the aggregates endpoints of the Sensu API
#
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
module.exports = class Aggregates extends SensuAPI
  # See {SensuAPI.constructor}
  constructor: ->
    super

  # Get an array of aggregate data from the Sensu API
  #
  # @example Using the Tousen namespace, get an array of aggregate data
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.aggregates.get_aggregates callback: (err, res) ->
  #     aggregates = res
  #
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_aggregates: ({callback}) ->
    @get path: 'aggregates', callback: callback

  # Get an array of aggregate data for a check from the Sensu API
  #
  # @example Using the Tousen namespace, get an array of aggregate data for the check "test_check"
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.aggregates.get_aggregates_for_check check: 'test_check', callback: (err, res) ->
  #     test_client_aggregates = res
  #
  # @param {String} check The check name for which to retrieve aggregates
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_aggregates_for_check: ({check, callback}) ->
    @get path: "aggregates/#{check}", callback: callback

  # Get an aggregate object from the Sensu API using a check name and an issued timestamp.
  #
  # @example Using the Tousen namespace, get an array of aggregate data for the check "test_check" and time 1425956879
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.aggregates.get_aggregate check: 'test_check', issued: 1425956879, callback: (err, res) ->
  #     test_client_aggregates = res
  #
  # @param {String} check The check name for which to retrieve an aggregate
  # @param {Integer} issued The integer "issued" timestamp for which to retrieve aggregates
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_aggregate: ({check, issued, callback}) ->
    @get path: "aggregates/#{check}/#{issued}", callback: callback
