app = {}
express = app.express = require('express')()

# Setup the config
env = express.settings.env
env = 'development' unless env
config = require('../config/config')[env]
config = require('../config/config')['development'] unless config
app.config = config

# Load controllers
app.controllers = require './controllers'

# Register all routes
router = app.router = new (require('./router'))(app)
require('../config/routes')(router)

express.listen config.port
console.log 'App listening on port ' + config.port
