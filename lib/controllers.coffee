###
Loads all controllers.
###
fs = require 'fs'
path = require 'path'

controllers = {}

files = fs.readdirSync 'app/controllers/'
for file in files
  controllerPath = path.join __dirname, '../app/controllers/', file 
  unless fs.statSync(controllerPath).isDirectory()
    controllers[path.basename(file, '.coffee')] = require controllerPath

module.exports = controllers
