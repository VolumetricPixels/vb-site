mongoose = require 'mongoose'

schema = new mongoose.Schema
  name: String

schema.virtual('link').get -> "/players/#{@name}"

module.exports = mongoose.model 'Player', schema
