# Provides functions and constants used by all API classes.
#
# @abstract API classes must inherit from SensuAPI
# @author Richard Chatterton <richard.chatterton@contegix.com>
# @copyright Contegix, LLC 2015
class SensuAPI

  # Construct a new SensuAPI instance.
  # @see https://github.com/technoweenie/node-scoped-http-client
  #
  # @param {ScopedClient} client Required. An instance of ScopedClient from scoped-http-client to be used for HTTP calls to the Sensu API
  # @param {Boolean} output_json Optional. If set to true, responses from the Sensu API will be returned as string JSON instead of deserialized objects.
  constructor: ({@client, @output_json}) ->

  # Known status codes for the Sensu API. Those with non-true values are used to generate error objects.
  status_codes: {
    200: true,
    201: true,
    202: true,
    204: true,
    400: "400: Request malformed.",
    404: "404: Requested object missing.",
    500: "500: Error.",
    503: "503: Unavailable."
  }

  # Return an error object for an unhandled response code.
  #
  # @param {Integer} code The unhandled response code for which the message should be generated.
  # @return {Error} 
  error_unknown: (code) ->
    new Error "#{code}: Unhandled response code."

  # Make a HTTP GET request, pass the response to a callback.
  #
  # @param {String} path The path to append to the base API URL when making the request.
  # @param {Function} callback The callback to receive the response, of the form void (error, object)
  get: ({path, callback}) ->
    @client.scope path, (cli) =>
      cli.get() (err, resp, body) =>
        @send_result err, resp, body, callback

  # Make a HTTP POST request with a data payload, pass the response to a callback.
  #
  # @param {String} path The path to append to the base API URL when making the request.
  # @param {String} payload The data payload to POST with the request.
  # @param {Function} callback The callback to receive the response, of the form void (error, object)
  post: ({path, payload, callback}) ->
    @client.scope path, (cli) =>
      cli.post(payload) (err, resp, body) =>
        @send_result err, resp, body, callback

  # Make a HTTP DELETE request, pass the response to a callback.
  #
  # @param {String} path The path to append to the base API URL when making the request.
  # @param {Function} callback The callback to receive the response, of the form void (error, object)
  delete: ({path, callback}) ->
    @client.scope path, (cli) =>
      cli.del() (err, resp, body) =>
        @send_result err, resp, body, callback

  # Callback which receives the response from ScopedClient's get, post, and del methods.
  #
  # Calls the callback with an error if:
  #
  #   1. An error was furnished by the caller.
  #
  #   2. The HTTP status code of the response maps to an error status in @status_codes
  #
  #   3. The HTTP status code of the response is not in @status_codes
  #
  #   4. @output_json is false and the output fails to be parsed as JSON.
  #
  # Otherwise, calls the callback with the parsed output of the response if @output_json != true, calls it with the string output if @output_json == true.
  # 
  # @param {Error} err Error object
  # @param {Obj} resp HTTP response object
  # @param {String} body HTTP response body
  # @param {Function} callback Callback to be called with the response, of the form void (error, object)
  send_result: (err, resp, body, callback) ->
    # If an error was generated during the API method call, pass it to the callback.
    if err
      callback(err, body)
    # Check if the status code is one we recognize. 
    else if @status_codes.hasOwnProperty(resp.statusCode)
      # If it's a status code that doesn't map to true, return an error with the text it maps to.
      if @status_codes[resp.statusCode] != true
        callback(new Error @status_codes[resp.statusCode], body)
      # If it's a status code that maps to "true", it's successful. Pass the body to the callback.
      else
        if @output_json or body == ""
          callback(err, body)
        else
          try
            output = JSON.parse(body)
          catch e
            err = e
          callback(err, output)
    # If we don't recognize the status code, pass an error to the callback.
    else
      callback(@error_unknown(resp.statusCode), body)

module.exports = SensuAPI
