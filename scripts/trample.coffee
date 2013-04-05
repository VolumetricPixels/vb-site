mongoose = require 'mongoose'

# Setup the config
env = process.env.NODE_ENV
env = 'development' unless env
config = require('../config/config')[env]
config = require('../config/config')['development'] unless config

mongoose.connect config.dburl

require('../db/trample') ->
  console.log 'Database trampled.'
  process.exit()
