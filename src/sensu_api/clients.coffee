SensuAPI = require '../sensu_api.coffee'

# Provides methods for accessing the clients endpoints of the Sensu API
# @see http://sensuapp.org/docs/latest/api_clients
#
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
class Clients extends SensuAPI
  # See {SensuAPI.constructor}
  constructor: ->
    super

  # Get an array of all client objects from the Sensu API
  #
  # @example Using the Tousen namespace, get an array of all clients
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.clients.get_clients callback: (err, res) ->
  #     clients = res
  #
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_clients: ({callback}) ->
    @get path: 'clients', callback: callback

  # Get a single client object from the Sensu API
  #
  # @example Using the Tousen namespace, get a client object for the client named "test_client"
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.clients.get_client client: 'test_client', callback: (err, res) ->
  #     test_client = res
  #
  # @param {String} client The name of the client to retrieve from the Sensu API
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_client: ({client, callback}) ->
    @get path: "clients/#{client}", callback: callback

  # Get the history object for a single client from the Sensu API
  #
  # @example Using the Tousen namespace, get a history object for the client named "test_client"
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.clients.get_client_history client: 'test_client', callback: (err, res) ->
  #     test_client_history = res
  #
  # @param {String} client The name of the client for which to retrieve history from the Sensu API
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_client_history: ({client, callback}) ->
    @get path: "clients/#{client}/history", callback: callback

  # Delete a single client from the Sensu API
  #
  # @example Using the Tousen namespace, delete the client named "test_client"
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.clients.delete_client client: 'test_client', callback: (err, res) ->
  #     test_client = res
  #
  # @param {String} client The name of the client to delete
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  delete_client: ({client, callback}) ->
    @delete path: "clients/#{client}", callback: callback

module.exports = Clients
