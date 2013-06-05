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

    s = new Server
      ip: server.ip
      desc: server.desc || null

    s.save (err) ->
      if err
        return res.send 400, err
      res.send 200

  delete_post: (req, res) ->
    server = req.body.server
    unless server
      return res.send 400, 'Unspecified server.'

    unless req.user.ownsServer server._id
      return res.send 400, 'Hacking attempt detected. Your IP has been logged.'

    Server.findById(server._id).remove (err) ->
      if err
        return res.send 400, 'Error: ' + err
      res.send 200

  edit: (req, res) ->
    unless req.user
      return res.redirect "/login?target=#{req.url}"

    Server.findOne(ip: @ip).exec (err, server) ->
      if err or server is null
        res.status(404).render 'layouts/404'
        return

      res.render 'servers/edit', server: server, target: (req.query.target || '/account')

  edit_post: (req, res) ->
    unless req.user
      return res.send 'Not logged in', 200

    server = req.body.server
    unless server
      return res.send 400, 'Unspecified server.'

    unless req.user.ownsServer server._id
      return res.send 400, 'Hacking attempt detected. Your IP has been logged.'

    Server.findById server._id, (err, s) ->
      s.ip = server.ip
      s.desc = server.desc

      s.save (err) ->
        if err
          if err.constructor.name is 'ValidationError' and err.errors.ip
            return res.send 400, 'Error: ' + err.errors.ip.type
          else
            return res.send 400, 'Error: ' + err

        res.send 200

  new: (req, res) ->
    unless req.user
      return res.redirect "/login?target=#{req.url}"

    res.render 'servers/new', target: (req.query.target || '/account')

  new_post: (req, res) ->
    unless req.user
      return res.send 'Not logged in', 200

    server = req.body.server
    unless server
      return res.send 400, 'Unspecified server.'

    s = new Server
      ip: server.ip
      desc: server.desc

    s.save (err) ->
      if err
        if err.constructor.name is 'ValidationError' and err.errors.ip
          return res.send 400, 'Error: ' + err.errors.ip.type
        else
          return res.send 400, 'Error: ' + err

      req.user.servers.push s
      req.user.save ->
        res.send 200

  show: (req, res) ->
    Server.findOne(ip: @ip).exec (err, server) ->
      if err or server is null
        res.status(404).render 'layouts/404'
        return

      Ban.find({server: server._id}).limit(50).sort('-date').populate('player').populate('issuer').exec (er, bans) ->
        Ban.count {server: server._id}, (e, count) ->
          res.render 'servers/show', server: server, bans: bans, banCount: count
