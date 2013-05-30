module.exports =
  index: (req, res) ->
    res.json 405, error: "You shouldn't be here."

  isGlobalBanned: (req, res) ->
    res.json 405, error: 'Unimplemented'

  ban_post: (req, res) ->
    res.json 405, error: 'Unimplemented'

  unban_post: (req, res) ->
    res.json 405, error: 'Unimplemented'
