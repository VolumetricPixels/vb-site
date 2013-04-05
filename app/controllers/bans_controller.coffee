Ban = require '../models/ban'

module.exports =
  index: (req, res) ->
    Ban.find().sort('-date').limit(10).populate('player').populate('server').exec (err, bans) ->
      if err
        console.log err
        return

      res.render 'bans/index', bans: bans
