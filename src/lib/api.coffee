module.exports = class API
  constructor: (@client) ->

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
    if err
      callback(err, body)
    if options.deserialize_response
      try
        res = JSON.parse(body)
      catch e
        err = e
        res = body
     else
       res = body
     callback(err, res)
