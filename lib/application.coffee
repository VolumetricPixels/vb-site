app = {}
express = require 'express'
x = app.x = express()

# Setup the config
env = x.settings.env
env = 'development' unless env
config = require('../config/config')[env]
config = require('../config/config')['development'] unless config
app.config = config

# Use connect-assets
x.use require('connect-assets')()

# Set up static files
x.use express.static __dirname + '/../public'
console.log __dirname

# Setup jade
x.set 'view engine', 'jade'
x.set 'view options', pretty: false, layout: true
x.set 'views', __dirname + '/../app/views'

# Load controllers
app.controllers = require './controllers'

# Register all routes
router = app.router = new (require('./router'))(app)
require('../config/routes')(router)

x.listen config.port
console.log 'App listening on port ' + config.port
