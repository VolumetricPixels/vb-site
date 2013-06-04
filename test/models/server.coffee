describe 'server', ->
  Ban = require '../../app/models/ban'
  Server = require '../../app/models/server'
  User = require '../../app/models/user'

  describe '#ownsServer', ->
    it 'should correctly identify the owned server', (done) ->
      Server.findOne {ip: 'play.gemcraft.net'}, (err, a) ->
        Server.findOne {ip: 'play.obsidiancraft.net'}, (err, b) ->
          User.findOne {username: 'test'}, (err, u) ->
            u.ownsServer(a._id).should.equal no
            u.ownsServer(b._id).should.equal yes
            done()
    it 'should correctly identify the owned server when populated', (done) ->
      Server.findOne {ip: 'play.gemcraft.net'}, (err, a) ->
        Server.findOne {ip: 'play.obsidiancraft.net'}, (err, b) ->
          User.findOne({username: 'test'}).populate('servers').exec (err, u) ->
            u.ownsServer(a._id).should.equal no
            u.ownsServer(b._id).should.equal yes
            done()

  describe '#remove', ->
    it 'should remove all related bans', (done) ->
      Server.findOne {ip: 'play.gemcraft.net'}, (err, server) ->
        
        Ban.count {server: server._id}, (err, count) ->
          count.should.not.equal 0

          server.remove ->
            Ban.count {server: server._id}, (err, count) ->
              count.should.equal 0
              done()
