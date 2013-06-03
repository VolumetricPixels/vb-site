exec = require('child_process').exec
mongoose = require 'mongoose'

config = require('./config/config')[process.env.NODE_ENV || 'development']

task 'db:seed', 'seed the database with the sample data', ->
  mongoose.connect config.dburl

  require('./db/seed') ->
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
