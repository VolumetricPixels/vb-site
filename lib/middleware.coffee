User = require '../app/models/user'

module.exports = (app) ->
  # User session middleware
  app.use (req, res, next) ->
    unless req.session.userId is undefined
      User.findById(req.session.userId).populate('players').populate('servers').exec (err, user) ->
        if user
          req.user = user
        else
          req.session.userId = null

        next()
      return

    # Check for cookies then login
    keyString = req.cookies.key

    unless keyString
      return next()

    key = JSON.parse keyString

    username = key.username
    password = key.password

    if username and password
      User.verifyLogin username, password, (err, user) ->
        if user
          req.session.userId = user._id.toString()
          req.user = user
        else
          res.clearCookie 'key'
        next()
    else
      next()

  # Global variables in templates middleware
  app.use (req, res, next) ->
    _render = res.render
    res.render = (view, options, fn) ->
      options = options || {}
      options.user = req.user || null
      _render.call res, view, options, fn
    next()
