module.exports =
  index: (req, res) ->
    res.render 'account/index'

  index_post: (req, res) ->
    res.send JSON.stringify req.body
