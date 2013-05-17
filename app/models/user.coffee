mongoose = require 'mongoose'

schema = new mongoose.Schema
  username: String
  email: String
  password: String # Hash
  players:
    type: [mongoose.Schema.ObjectId]
    ref: 'Player'

module.exports = mongoose.model 'User', schema 
