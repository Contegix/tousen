SensuAPI = require './sensu_api.coffee'

module.exports = class Clients extends SensuAPI
  constructor: ->
    super

  get_clients: (options, callback) ->
    @get 'clients', options, callback

  get_client: (client, options, callback) ->
    @get "clients/#{client}", options, callback

  get_client_history: (client, options, callback) ->
    @get "clients/#{client}/history", options, callback

  delete_client: (client, options, callback) ->
    @delete "clients/#{client}", options, callback
