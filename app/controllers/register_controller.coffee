User = require '../models/user'

module.exports =
  index: (req, res) ->
    if req.user
      res.redirect '/'

    res.render 'register/index'

  index_post: (req, res) ->
    body = req.body
    unless body
      return res.send 'No form data received', 400

    User.register body.user, body.email, (err, user) ->
      if err
        return res.send err, 400

      return res.send 200
