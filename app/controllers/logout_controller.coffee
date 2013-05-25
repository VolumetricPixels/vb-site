module.exports =
  index: (req, res) ->
    req.session.userId = null
    res.clearCookie 'key'
    res.redirect '/'
