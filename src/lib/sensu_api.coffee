module.exports = class SensuAPI
  constructor: (@client) ->

  status_codes: {
    200: true,
    201: true,
    202: true,
    204: true,
    400: "Sensu API response 400: Request malformed.",
    404: "Sensu API response 404: Requested object missing.",
    500: "Sensu API response 500: Error.",
    503: "Sensu API response 503: Unavailable."
  }

  error_unknown: (code) ->
    new Error "Sensu API response #{code}: Unknown response."

  get: (path, options, callback) ->
    @client.scope path, (cli) =>
      cli.get() (err, resp, body) =>
        @send_result err, resp, body, options, callback

  post: (path, options, callback) ->
    @client.scope path, (cli) =>
      cli.post(options.payload) (err, resp, body) =>
        @send_result err, resp, body, options, callback

  delete: (path, options, callback) ->
    @client.scope path, (cli) =>
      cli.del() (err, resp, body) =>
        @send_result err, resp, body, options, callback

  send_result: (err, resp, body, options, callback) ->
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
        if options.deserialize_response # Perhaps we should just deserialize by default?
          try
            output = JSON.parse(body)
          catch e
            err = e
            output = body
        else
          output = body
        callback(err, output)
    # If we don't recognize the status code, pass an error to the callback.
    else
      callback(@error_unknown(resp.statusCode), body)
