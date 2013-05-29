Player = require '../models/player'

module.exports =
  index: (req, res) ->
    Player.find().limit(25).exec (err, players) ->
      res.render 'players/index', players: players

  show: (req, res, next) ->
    name = req.params.name
    unless name
      return next()

    Player.findOne {name: req.params.name}, (err, player) ->
      unless player
        return next()

      res.render 'players/show', player: player
