mongoose = require 'mongoose'

schema = new mongoose.Schema
  name: String
  apikey: String

schema.virtual('link').get -> "/servers/show/#{@_id}"

module.exports = mongoose.model 'Server', schema
