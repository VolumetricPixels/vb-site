module.exports =
  index: (req, res) ->
    res.render 'account/index'

  index_post: (req, res) ->
    body = req.body

    if body.email
      email = body.email.email
      unless email
        return res.send 'Please input an email address.', 400
    else
      res.send 400, JSON.stringify(req.body)
