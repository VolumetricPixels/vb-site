mongoose = require 'mongoose'
require './player'
require './server'

schema = new mongoose.Schema
  player:
    type: mongoose.Schema.ObjectId
    ref: 'Player'
    required: yes
  server:
    type: mongoose.Schema.ObjectId
    ref: 'Server'
    required: yes
  reason: String
  issuer:
    type: mongoose.Schema.ObjectId
    ref: 'Player'
  date:
    type: Date
    required: yes
  end: Date

schema.virtual('link').get -> "/bans/#{@_id}"

module.exports = mongoose.model 'Ban', schema
