###
Loads all controllers.
###
fs = require 'fs'
path = require 'path'

controllers = {}

files = fs.readdirSync 'src/controllers/'
for file in files
  controllerPath = path.join __dirname, './controllers/', file 
  unless fs.statSync(controllerPath).isDirectory()
    controllers[path.basename(file, '_controller.coffee')] = require controllerPath

module.exports = controllers
