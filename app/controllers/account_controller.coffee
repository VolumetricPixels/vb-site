module.exports =
  index: (req, res) ->
    unless req.user
      return res.redirect '/login?target=/account'

    res.render 'account/index'

  index_post: (req, res) ->
    unless req.user
      return res.send 'Not logged in', 200

    body = req.body

    if body.email
      email = body.email.email
      unless email
        return res.send 'Please input an email address.', 400

      # TODO Change email here
      return res.send 200

    else if body.pass
      current = body.pass.current
      unless current
        return res.send 'Please input your current password.'

      pass = body.pass.pass
      unless pass
        return res.send 'Please input a new password.', 400

      confirm = body.pass.confirm
      unless confirm
        return res.send 'Please confirm your password.', 400

      if pass isnt confirm
        return res.send 'The passwords do not match.', 400

      req.user.checkPassword current, (err, valid) ->
        unless valid
          return res.send 'Invalid password.', 400

        req.user.setPassword pass, ->
          res.send 200

    else
      res.send 400, JSON.stringify(req.body)
