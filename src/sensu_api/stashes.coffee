SensuAPI = require '../sensu_api'

# Provides methods for accessing the stashes endpoints of the Sensu API
# @see http://sensuapp.org/docs/latest/api_stashes
#
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
class Stashes extends SensuAPI
  # See {SensuAPI#constructor}
  constructor: ->
    super

  # Get an array of all stash objects from the Sensu API
  #
  # @example Using the Tousen namespace, get an array of all stashes from the Sensu API
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.stashes.get_stashes callback: (err, res) ->
  #     stashes = res
  #
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_stashes: ({callback}) ->
    @get path: 'stashes', callback: callback

  # Get a single stash object by path from the Sensu API
  #
  # @example Using the Tousen namespace, get a single stash object with path "silence/test_client/test_check" from the Sensu API
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.stashes.get_stash path: 'silence/test_client/test_check', callback: (err, res) ->
  #     stash = res
  #
  # @param {String} path The path of the stash to retrieve
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_stash: ({path, callback}) ->
    @get path: "stashes/#{path}", callback: callback

  # Create a stash with an object defining the stash's path, content, and expiration.
  #
  # @example Using the Tousen namespace, create a stash with path "silence/test_client", content containing a reason, and an expiry of one hour
  #   Tousen = require 'tousen'
  #   data = { 
  #     path: "silence/test_client", 
  #     content: { reason: "This client was silenced for a reason." },
  #     expire: 3600
  #   }
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.stashes.create_stash data: data, callback: (err, res) ->
  #     response = res
  #
  # @param {Object} data An object describing the stash to be created
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  create_stash: ({data, callback}) ->
    try
      payload = JSON.stringify(data)
      @post path: "stashes", payload: payload, callback: callback
    catch e
      callback e, payload

  # Create a stash at a path with an object defining the stash's content
  #
  # @example Using the Tousen namespace, create a stash with path "silence/test_client" and content containing a reason
  #   Tousen = require 'tousen'
  #   data = { 
  #     reason: "This client was silenced for a reason."
  #   }
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.stashes.create_stash_path path: "silence/test_client", data: data, callback: (err, res) ->
  #     response = res
  #
  # @param {String} path The path of the stash to be created
  # @param {Object} data An object describing the content of the stash to be created
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  create_stash_path: ({path, data, callback}) ->
    if data?
      try
        payload = JSON.stringify(data)
      catch e
        callback e, payload
    @post path: "stashes/#{path}", payload: payload, callback: callback

  # Delete the stash at the specified path
  #
  # @example Using the Tousen namespace, delete a stash with path "silence/test_client"
  #   Tousen = require 'tousen'
  #   data = { 
  #     reason: "This client was silenced for a reason."
  #   }
  #   sensu_api = new Tousen url: "http://sensu.example.com:4567"
  #   sensu_api.stashes.delete_stash path: "silence/test_client", callback: (err, res) ->
  #     response = res
  #
  # @param {String} path The path of the stash to be deleted
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  delete_stash: ({path, callback}) ->
    @delete path: "stashes/#{path}", callback: callback

module.exports = Stashes
