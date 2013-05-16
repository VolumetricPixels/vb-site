Ban = require '../models/ban'
Server = require '../models/server'

module.exports =
  index: (req, res) ->
    Server.find().limit(10).exec (err, servers) ->
      if err
        console.log err
        return

      res.render 'servers/index', servers: servers

  show: (req, res) ->
    Server.findOne(_id: @id).exec (err, server) ->
      if err or server is null
        res.status(404).render 'layouts/404'
        return

      recentBans = Ban.find({server: server._id}).limit(50).sort('-date').populate('player').exec (err, bans) ->
        res.render 'servers/show', server: server, bans: bans
