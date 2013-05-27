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
    else
      res.send 400, JSON.stringify(req.body)
