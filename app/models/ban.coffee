mongoose = require 'mongoose'
require './player'
require './server'

schema = new mongoose.Schema
  player:
    type: mongoose.Schema.ObjectId
    ref: 'Player'
  server:
    type: mongoose.Schema.ObjectId
    ref: 'Server'
  reason: String
  admin: String
  date: Date
  end: Date
  global: Boolean

module.exports = mongoose.model 'Ban', schema
