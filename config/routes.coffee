controllers = require '../lib/controllers'

module.exports = (app) ->

  route = (matcher, handler) ->
    app.get matcher, (req, res) ->
      handler.call req.params, req, res

  route '/', controllers.index
