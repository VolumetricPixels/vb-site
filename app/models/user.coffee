bcrypt = require 'bcrypt'
crypto = require 'crypto'
mongoose = require 'mongoose'
sendgrid = new require('sendgrid').SendGrid process.env.SENDGRID_USERNAME, process.env.SENDGRID_PASSWORD

schema = new mongoose.Schema
  username: String
  email: String
  password: String # Hash
  players:
    type: [mongoose.Schema.ObjectId]
    ref: 'Player'

schema.statics.randomPass = (cb) ->
  crypto.randomBytes 6, (ex, buf) ->
    cb buf.toString('base64').replace(/\//g, '_').replace(/\+/g, '-')

schema.statics.register = (username, email, cb) ->
  return cb 'Please enter a username.' unless username
  username = username.toLowerCase()
  return cb 'Please enter an email.' unless email
  email = email.toLowerCase()

  query =
    $or: [
      {username: username},
      {email: email}
    ]

  @findOne query, (err, user) ->
    if user
      if user.username is username
        cb 'Username is already in use.', null
      else
        cb 'Email is already in use.', null
      return
    
    # Not in use
    cb null, null

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
  @email = @email.toLowerCase()
  next()

module.exports = mongoose.model 'User', schema 
