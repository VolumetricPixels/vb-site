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

schema.methods.countBans = (query, cb) ->
  query.player = @_id
  mongoose.model('Ban').count query, cb

schema.methods.findBans = (query, cb) ->
  query.player = @_id
  mongoose.model('Ban').find query, cb

schema.methods.isBanned = (server, cb) ->
  query =
    status: 'banned'
    $or: [
      {end: $gt: new Date()}, # end hasn't happened
      {end: null} # end is null
    ]

  @countBans query, (err, count) ->
    cb err, (server.strictness > count)

schema.virtual('link').get -> "/players/#{@name}"

schema.pre 'save', (next) ->
  @nameLower = @name.toLowerCase()
  next()

module.exports = mongoose.model 'Player', schema
