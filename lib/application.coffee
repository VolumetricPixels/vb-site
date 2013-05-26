app = {}
express = require 'express'
x = app.x = express()

# Setup the config
env = x.settings.env
app.env = env = 'development' unless env
config = require('../config/config')[env]
config = require('../config/config')['development'] unless config
app.config = config

# Use connect-assets
if config.fastAssets
  opts =
    detectChanges: no
else
  opts = {}

x.use require('connect-assets') opts

# Parse bodies - required for forms
x.use express.bodyParser()

# Use sessions
x.use express.cookieParser()
x.use express.session secret: 'i dont think it matters if my secret is on github'

# Set up static files
x.use express.static __dirname + '/../public'
console.log __dirname

# Setup jade
x.set 'view engine', 'jade'
x.set 'view options', pretty: yes
x.set 'views', __dirname + '/../app/views'

# Load controllers
app.controllers = require './controllers'

# Load db
mongoose = require 'mongoose'
mongoose.connect config.dburl

# Load email
app.email = require './email'

# Load middleware
require('./middleware')(x)

# Register all routes
router = app.router = new (require('./router'))(app)
require('../config/routes')(router)

x.listen config.port
console.log 'App listening on port ' + config.port
