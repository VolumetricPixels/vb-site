Ban = require '../models/ban'
Server = require '../models/server'

module.exports =
  index: (req, res) ->
    Server.find().limit(10).exec (err, servers) ->
      if err
        console.log err
        return

      res.render 'servers/index', servers: servers

  index_post: (req, res) ->
    server = req.body.server
    unless server
      return res.send 400, 'No server specified'
    
    unless server.ip
      return res.send 400, 'Please enter a server IP.'

    server = new Server
      name: server.name || null
      ip: server.ip

    server.generateKey ->
      server.save (err) ->
        if err
          return res.send 400, err

  show: (req, res) ->
    Server.findOne(_id: @id).exec (err, server) ->
      if err or server is null
        res.status(404).render 'layouts/404'
        return

      Ban.find({server: server._id}).limit(50).sort('-date').populate('player').exec (er, bans) ->
        Ban.count {server: server._id}, (e, count) ->
          res.render 'servers/show', server: server, bans: bans, banCount: count
