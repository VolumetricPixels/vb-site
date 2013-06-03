describe 'server', ->
  Ban = require '../../app/models/ban'
  Server = require '../../app/models/server'

  describe '#remove', ->
    it 'should remove all related bans', (done) ->
      Server.findOne {ip: 'play.gemcraft.net'}, (err, server) ->
        
        Ban.count {server: server._id}, (err, count) ->
          count.should.not.equal 0

          server.remove ->
            Ban.count {server: server._id}, (err, count) ->
              count.should.equal 0
              done()
