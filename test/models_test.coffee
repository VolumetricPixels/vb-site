mongoose = require 'mongoose'

seed = require '../db/seed'
trample = require '../db/trample'

describe 'models/', ->
  before (done) -> 
    mongoose.connect require('../config/config')[process.env.NODE_ENV || 'development'].dburl
    done()

  beforeEach seed

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
