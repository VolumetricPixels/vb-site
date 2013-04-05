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

  get: (path, handlerName) ->
    @app.x.get path, (req, res) =>
      @_getHandler(handlerName).call req.params, req, res
