exec = require('child_process').exec
mongoose = require 'mongoose'

# Setup the config
env = process.env.NODE_ENV
env = 'development' unless env
config = require('./config/config')[env]
config = require('./config/config')['development'] unless config

task 'db:seed', 'seed the database with the sample data', ->
  mongoose.connect config.dburl

  require('./db/seeds') ->
    console.log 'Database seeded.'
    process.exit()

task 'db:trample', 'clear all the data in the database', ->
  mongoose.connect config.dburl

  require('./db/trample') ->
    console.log 'Database trampled.'
    process.exit()

task 'server', 'start the server', ->
  require './bootstrap'

task 'test', 'run unit tests', ->
  exec 'NODE_ENV=test ./node_modules/mocha/bin/mocha ./test/*.coffee', (err, out) ->
    throw err if err
    console.log out
