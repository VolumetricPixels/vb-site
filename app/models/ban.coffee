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
  by:
    type: mongoose.Schema.ObjectId
    ref: 'Player'
  date: Date
  end: Date
  global: Boolean

schema.virtual('link').get -> "/bans/#{@_id}"

module.exports = mongoose.model 'Ban', schema
