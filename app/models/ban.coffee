mongoose = require 'mongoose'

schema = new mongoose.Schema
  # Player banned
  player:
    type: mongoose.Schema.ObjectId
    ref: 'Player'
    required: yes

  # Server that issued the ban
  server:
    type: mongoose.Schema.ObjectId
    ref: 'Server'
    required: yes

  # Ban reason
  reason:
    type: String
    default: null
    get: (s) -> s || 'Unspecified'

  # Player who created the ban; null means banned from console
  issuer:
    type: mongoose.Schema.ObjectId
    ref: 'Player'
    default: null
  
  # Date of ban start
  date:
    type: Date
    required: yes

  # Date on which ban ends -- null is an indefinite ban
  end:
    type: Date
    default: null

  # Status of the ban.
  # unbanned - ban unbanned by server
  # pending - banned on server, vb hasnt declared a verdict
  # invalid - banned on server, vb considers ban invalid
  # banned - ban approved by VB team
  status:
    type: String
    default: 'pending'

schema.statics.fromJSON = (server, json, cb) ->
  Player = mongoose.model 'Player'

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
