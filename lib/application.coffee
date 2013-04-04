app = require('express')()

# Setup the config
env = app.settings.env
env = 'development' unless env
config = require('../config/config')[env]
config = require('../config/config')['development'] unless config

# Register all routes
require('../config/routes')(app)

app.listen config.port
console.log 'App listening on port ' + config.port
