mongoose = require 'mongoose'

schema = new mongoose.Schema
  name: type: String
  ip: type: String, required: yes
  apikey: String

schema.virtual('link').get -> "/servers/#{@_id}"

module.exports = mongoose.model 'Server', schema
