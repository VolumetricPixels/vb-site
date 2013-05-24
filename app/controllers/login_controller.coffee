User = require '../models/user'

module.exports =
  index: (req, res) ->
    res.render 'login/index'

  index_post: (req, res) ->
    body = req.body
    unless body
      return res.send 400

    User.verifyLogin body.user, body.pass, (err, user) ->
      unless user
        return res.send 400

      console.log 'Logged in as user ' + user.username
      return res.send 200
