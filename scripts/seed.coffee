mongoose = require 'mongoose'

# Setup the config
env = process.env.NODE_ENV
env = 'development' unless env
config = require('../config/config')[env]
config = require('../config/config')['development'] unless config

mongoose.connect config.dburl

require('../db/seeds') ->
  console.log 'Database seeded.'
  process.exit()
