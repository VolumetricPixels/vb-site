module.exports =
  index: (req, res) ->
    res.render 'logout/index'

  index_post: (req, res) ->
    req.session.userId = null
    res.clearCookie 'key'
    res.redirect '/'
