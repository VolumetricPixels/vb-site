module.exports =
  index: (req, res) ->
    res.redirect '/'

  isGlobalBanned: (req, res) ->
    res.json 405, error: 'Unimplemented'

  ban_post: (req, res) ->
    res.json 405, error: 'Unimplemented'

  unban_post: (req, res) ->
    res.json 405, error: 'Unimplemented'
