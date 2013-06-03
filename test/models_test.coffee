mongoose = require 'mongoose'

seed = require '../db/seed'
trample = require '../db/trample'

describe 'models/', ->
  before (done) -> 
    mongoose.connect require('../config/config')[process.env.NODE_ENV || 'development'].dburl
    done()

  beforeEach seed

  describe 'server', ->
    Ban = require '../app/models/ban'
    Server = require '../app/models/server'

    describe '#remove', ->
      it 'should remove all related bans', (done) ->
        Server.findOne {ip: 'play.gemcraft.net'}, (err, server) ->
          
          Ban.count {server: server._id}, (err, count) ->
            count.should.not.equal 0

            server.remove ->
              Ban.count {server: server._id}, (err, count) ->
                count.should.equal 0
                done()

  describe 'user', ->
    User = require '../app/models/user'

    it 'should check hashed passwords correctly', (done) ->
      testUser = new User name: 'test', email: 'test@example.com'
      testUser.setPassword 'complicated', ->
        testUser.checkPassword 'complicated', (err, res) ->
          res.should.equal true
          done()

  afterEach trample

  after (done) ->
    mongoose.disconnect ->
      done()
