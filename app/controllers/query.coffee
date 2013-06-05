Ban = require '../models/ban'
Player = require '../models/player'

module.exports =
  index: (req, res) ->
    res.json 405, error: "You shouldn't be here."

  isBanned: (req, res) ->
    unless req.query.player
      return res.json 422, error: 'Player must be specified.'

    Player.getPlayer req.query.player, (e, player) ->
      player.isBanned req.server, (e, b) ->
        res.json 200, result: b
 
  ban_post: (req, res) ->
    Ban.fromJSON req.server, req.body, (err, ban) ->
      return res.json 422, error: err if err
      res.json 200, ban.toObject()

  unban_post: (req, res) ->
    unless req.body.player
      return res.json 422, error: 'Player must be specified.'

    now = new Date

    Player.getPlayer req.body.player, (error, player) ->
      return res.json 422, error: error if error

      query =
        server: req.server._id
        player: player._id
        $or: [
          {end: $gt: now}, # end hasn't happened
          {end: null} # end is null
        ],
        status: $ne: 'unbanned'

      Ban.findOne query, (err, ban) ->
        return res.json 422, error: err if err
        unless ban
          return res.json 422, error: 'Player not banned on server'

        ban.status = 'unbanned'
        ban.save (e) ->
          return res.json 422, error: e if e
          res.json 200, result: yes
