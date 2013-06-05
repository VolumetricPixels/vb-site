mongoose = require 'mongoose'

seed = require '../db/seed'
trample = require '../db/trample'

describe 'models/', ->
  before (done) -> 
    mongoose.connect require('../config/config')[process.env.NODE_ENV || 'development'].dburl
    done()

  beforeEach seed

  require './models/player'
  require './models/server'
  require './models/user'

  afterEach trample

  after (done) ->
    mongoose.disconnect ->
      done()
