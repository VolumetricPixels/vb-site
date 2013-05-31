Ban = require '../models/ban'

module.exports =
  index: (req, res) ->
    res.json 405, error: "You shouldn't be here."

  isBanned: (req, res) ->
    res.json 405, error: 'Unimplemented'

  ban_post: (req, res) ->
    Ban.fromJSON req.server, req.body, (err, ban) ->
      return res.json 422, error: err if err
      res.json 200, ban.toObject()

  unban_post: (req, res) ->
    res.json 405, error: 'Unimplemented'
