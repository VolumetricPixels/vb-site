Ban = require '../models/ban'

module.exports =
  index: (req, res) ->
    Ban.find().sort('-date').limit(10).populate('player').populate('server').populate('by').exec (err, bans) ->
      if err
        console.log err
        return

      res.render 'bans/index', bans: bans

  show: (req, res) ->
    Ban.findOne(_id: @id).populate('player').populate('server').populate('by').exec (err, ban) ->
      if err or ban is null
        res.status(404).render 'layouts/404'
        return

      res.render 'bans/show', ban: ban
