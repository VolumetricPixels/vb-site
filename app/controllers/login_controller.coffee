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

      # TODO implement an actually secure system
      if body.remember
        key = JSON.stringify
          username: body.user
          password: body.pass

        res.cookie 'key', key, { expires: new Date(Date.now() + 2 * 604800000), path: '/' }

      req.session.userId = user._id.toString()
      return res.send 200
