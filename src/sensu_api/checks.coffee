SensuAPI = require '../sensu_api.coffee'

# Provides methods for accessing the checks endpoints of the Sensu API
# @see http://sensuapp.org/docs/latest/api_checks
#
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
class Checks extends SensuAPI
  # See {SensuAPI.constructor}
  constructor: ->
    super

  # Get an array of all checks from the Sensu API
  #
  # @example Using the Tousen namespace, get an array of all checks
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.checks.get_checks callback: (err, res) ->
  #     checks = res
  #
  # @param {Function} callback The callback to receive the response, of the form function(error, response) 
  get_checks: ({callback}) ->
    @get path: 'checks', callback: callback

  # Get an a check object from the Sensu API
  #
  # @example Using the Tousen namespace, get the check object for a check named "test_check"
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.checks.get_check check: "test_check", callback: (err, res) ->
  #     check = res
  #
  # @param {String} check The name of the check which should be retrieved
  # @param {Function} callback The callback to receive the response, of the form function(error, response) 
  get_check: ({check, callback}) ->
    @get path: "checks/#{check}", callback: callback

  # Request a check run via the Sensu API
  #
  # @example Using the Tousen namespace, request a run of the check "test_check" for subscribers "production"
  #   data = {
  #    check: "chef_client_process",
  #    "subscribers": ["production"]
  #   }
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.checks.get_check data: data, callback: (err, res) ->
  #     response = res
  #
  # @param {Object} data An object defining the check(s) which should be run
  # @param {Function} callback The callback to receive the response, of the form function(error, response) 
  request_run: ({data, callback}) ->
    try
      payload = JSON.stringify(data)
      @post path: "request", payload: payload, callback: callback
    catch e
      callback e, data

module.exports = Checks
