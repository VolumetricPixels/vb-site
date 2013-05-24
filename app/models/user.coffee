bcrypt = require 'bcrypt'
mongoose = require 'mongoose'

schema = new mongoose.Schema
  username: String
  email: String
  password: String # Hash
  players:
    type: [mongoose.Schema.ObjectId]
    ref: 'Player'

schema.statics.verifyLogin = (username, password, cb) ->
  @findOne {username: username.toLowerCase()}, (err, user) ->
    if err or not user
      return cb(err, null)

    # Password validation
    bcrypt.compare password, user.password, (err, res) ->
      if err or not res
        return cb(err, null)

      return cb(err, user)

schema.pre 'save', (next) ->
  @username = @username.toLowerCase()
  next()

module.exports = mongoose.model 'User', schema 
