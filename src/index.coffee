app = require('express')()

# Setup the config
env = process.env.NODE_ENV
env = 'development' unless env
config = require('../config/config')[env]
config = require('../config/config')['development'] unless config

# Register all routes
require('./routes')(app)

app.listen config.port
