bcrypt = require 'bcrypt'
crypto = require 'crypto'
gravatar = require 'gravatar'
mongoose = require 'mongoose'
emailModule = require '../../lib/email'

toLower = (v) -> v.toLowerCase()

schema = new mongoose.Schema
  username: type: String, required: yes, unique: yes, set: toLower
  email: type: String, required: yes, unique: yes, set: toLower
  password: type: String, required: yes # Hash
  role: type: String, required: yes, default: 'user'

  players: [
    type: mongoose.Schema.ObjectId
    ref: 'Player'
  ]

  servers: [
    type: mongoose.Schema.ObjectId
    ref: 'Server'
  ]

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

  @findOne query, (err, user) =>
    if user
      if user.username is username
        cb 'Username is already in use.', null
      else
        cb 'Email is already in use.', null
      return
    
    @randomPass (pass) =>
      user = new this
        username: username
        email: email

      user.setPassword pass, =>

        user.save (err, user) =>
          # Email them
          emailModule.send
            to: email
            from: 'register@volumetricbans.com'
            fromname: 'VolumetricBans'
            subject: 'Your login information'
            text: """
              Dear #{username},

              Thank you for registering an account with Volumetric Bans.
              Your login details are as follows:

                 Username: #{username}
                 Password: #{pass}

              You can login to your account at http://volumetricbans.com/login.

              Regards,
              The Volumetric Bans Team          
            """
          , (success, message) =>
            if success
              cb null, user
            else
              cb 'Error with email delivery', user


schema.statics.verifyLogin = (username, password, cb) ->
  @findOne(username: username.toLowerCase()).populate('players').populate('servers').exec (err, user) ->
    if err or not user
      return cb(err, null)

    # Password validation
    user.checkPassword password, (err, res) ->
      if err or not res
        return cb(err, null)

      return cb(err, user)

schema.methods.gravatar = (opts) -> gravatar.url @email, opts

schema.methods.checkPassword = (password, cb) ->
  bcrypt.compare password, @password, (err, res) ->
    cb err, res

schema.methods.setPassword = (password, cb) ->
  bcrypt.hash password, 10, (err, hash) =>
    @password = hash
    @save cb

schema.methods.ownsServer = (id) ->
  ### Checks if the user owns the server with the given ID ###
  id = id.toString()
  for sv in @servers
    if sv._id
      sid = sv._id.toString()
    else
      sid = sv.toString()

    if sid is id
      return yes
  return no

module.exports = mongoose.model 'User', schema 
