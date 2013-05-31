crypto = require 'crypto'
mongoose = require 'mongoose'

schema = new mongoose.Schema
  name: type: String, default: null
  ip: type: String, required: yes
  apikey: String

schema.statics.generateKey = (cb) ->
  crypto.randomBytes 20, (ex, buf) ->
    @apikey = buf.toString('base64').replace(/\//g, '_').replace(/\+/g, '-')
    cb @apikey

schema.virtual('link').get -> "/servers/#{@_id}"

module.exports = mongoose.model 'Server', schema
