SensuAPI = require '../sensu_api'

# Provides methods for accessing API info endpoints of the Sensu API
# @see http://sensuapp.org/docs/latest/api_info
#
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
class Info extends SensuAPI
  # See {SensuAPI#constructor}
  constructor: ->
    super

  # Get the Sensu info object from the Sensu API
  # 
  # @example Using the Tousen namespace, get the Sensu info object from the Sensu API
  #   Tousen = require 'tousen'
  #   sensu_api = new Tousen url: 'http://sensu.example.com:4567'
  #   sensu_api.info.get_info callback: (err, res) ->
  #     info = res
  #
  # @param {Function} callback The callback to receive the response, of the form function(error, response)
  get_info: ({callback}) ->
    @get path: 'info', callback: callback

module.exports = Info
