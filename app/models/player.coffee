mongoose = require 'mongoose'

schema = new mongoose.Schema
  name: String
  nameLower: String

schema.statics.getPlayer = (name, cb) ->
  unless name
    cb 'No name specified', null

  unless name.constructor.name is 'String'
    console.log (name instanceof String)
    cb 'Name not string', null

  @findOne {nameLower: name.toLowerCase()}, (err, player) =>
    if player
      cb err, player
    else
      player = new this name: name
      player.save (e) ->
        cb e, player

schema.virtual('link').get -> "/players/#{@name}"

schema.pre 'save', (next) ->
  @nameLower = @name.toLowerCase()
  next()

module.exports = mongoose.model 'Player', schema
