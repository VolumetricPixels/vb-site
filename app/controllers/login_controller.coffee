module.exports =
  index: (req, res) ->
    res.render 'login/index'

  index_post: (req, res) ->
    body = req.body
    if body and body.user is 'john' and body.pass is '123456'
      res.send 'Works'
    else
      res.send 'doesnt work'
