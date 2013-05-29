module.exports = class Router
  constructor: (@app) ->

  _getHandler: (handlerName) ->
    parts = handlerName.split '#'
    controller = parts[0]
    handler = if parts.length > 1 then parts[1] else 'index'

    theController = @app.controllers[controller]
    unless theController
      throw new Error "Could not find controller `#{controller}'"

    theHandler = theController[handler]
    unless theHandler
      throw new Error "Could not find handler `#{handler}' in `#{controller}'"

    return theHandler

  all: (path, handlerName) ->
    handler = @_getHandler handlerName
    @app.x.all path, (req, res) =>
      handler.call req.params, req, res

  get: (path, handlerName) ->
    handler = @_getHandler handlerName
    @app.x.get path, (req, res) =>
      handler.call req.params, req, res

  post: (path, handlerName) ->
    handler = @_getHandler handlerName
    @app.x.post path, (req, res) =>
      handler.call req.params, req, res
