mongoose = require 'mongoose'
Player = require './player'
Server = require './server'

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

schema.statics.fromJSON = (server, json, cb) ->
  isValidDate = (d) ->
    return false if Object::toString.call(d) isnt '[object Date]'
    return !isNaN d.getTime()

  Player.getPlayer json.player, (err, player) =>
    if err
      return cb "Player error: #{err}", null

    Player.getPlayer json.issuer, (err, issuer) =>
      date = new Date json.date
      unless isValidDate date
        date = new Date()

      end = new Date json.end
      unless isValidDate end
        end = null

      ban = new this
        player: player
        server: server
        reason: json.reason || null
        issuer: issuer # Null would mean banned by console
        date: date
        end: end

      ban.save (e) ->
        cb e, ban

schema.set 'toObject',
  getters: true
  transform: (doc, ret, opts) ->
    delete ret.id
    return

schema.virtual('link').get -> "/bans/#{@_id}"

schema.virtual('permanent').get -> not @temporary

schema.virtual('temporary').get -> @end isnt null

module.exports = mongoose.model 'Ban', schema
