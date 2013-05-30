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
  end:
    type: Date
    default: null

schema.virtual('link').get -> "/bans/#{@_id}"

schema.virtual('permanent').get -> not @temporary

schema.virtual('temporary').get -> @end isnt null

module.exports = mongoose.model 'Ban', schema
