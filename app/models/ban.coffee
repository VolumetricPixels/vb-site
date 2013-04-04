mongoose = require 'mongoose'
player = require 'player'
server = require 'server'

schema = new mongoose.Schema
  player: Player.schema
  server: Server.schema
  reason: String
  admin: String
  date: Date
  end: Date
  global: Boolean

module.exports = mongoose.model 'Ban', schema
