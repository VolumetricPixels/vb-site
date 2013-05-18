User = require '../app/models/user'

module.exports = (app) ->
  # User session middleware
  app.use (req, res, next) ->
    unless req.session.user is undefined
      next()
      return

    # Check for cookies then login
    username = req.cookies.user
    password = req.cookies.pass
    if username and password
      # TODO hash
      User.findOne({username: username, password: password}).exec (err, user) ->
        unless user
          next()
          return
        req.session.user = user
        next()
      return

    next()
