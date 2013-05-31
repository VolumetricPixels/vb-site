crypto = require 'crypto'
mongoose = require 'mongoose'

schema = new mongoose.Schema
  ip: type: String, required: yes
  desc: type: String, default: null
  apikey: type: String

schema.methods.generateKey = (cb) ->
  crypto.randomBytes 20, (ex, buf) =>
    @apikey = buf.toString('base64').replace(/\//g, '_').replace(/\+/g, '-')
    model = @model @constructor.modelName
    model.findOne {apikey: @apikey}, (err, doc) =>
      if doc
        @generateKey cb
      else
        cb @apikey

schema.pre 'save', (next) ->
  unless @apikey
    @generateKey ->
      next()
  else
    next()

schema.virtual('link').get -> "/servers/#{@_id}"

module.exports = mongoose.model 'Server', schema
