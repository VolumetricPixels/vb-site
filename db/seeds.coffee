async = require 'async'
bcrypt = require 'bcrypt'

Ban = require '../app/models/ban'
Player = require '../app/models/player'
Server = require '../app/models/server'
User = require '../app/models/user'

module.exports = (done) ->
  albireox = new Player name: 'albireox'
  dzineit = new Player name: 'dzineit'
  maxorq = new Player name: 'Maxorq'
  dyrus = new Player name: 'Dyrus'

  gemcraft = new Server name: 'GemCraft', apikey: 'x23fseklfsdfms'
  obsidiancraft = new Server name: 'ObsidianCraft', apikey: '==2313ASDASD'

  bans = [
    new Ban
      player: albireox
      server: gemcraft
      reason: 'griefing'
      admin: 'acidsin'
      date: new Date("2013-04-03 13:23:15")
      end: new Date("2013-04-04 13:23:15")
      global: true
  ]

  
  test_user = new User
    username: 'test'
    email: 'test@gmail.com'
    password: hash 'passw0rd'
    players: [albireox]

  async.parallel [
    (cb) -> albireox.save cb,
    (cb) -> dzineit.save cb,
    (cb) -> maxorq.save cb,
    (cb) -> dyrus.save cb,

    (cb) -> gemcraft.save cb,
    (cb) -> obsidiancraft.save cb,

    (cb) -> test_user.save cb
  ], (err, results) ->
    async.forEach bans, (item, callback) ->
      item.save callback
    , done

hash = (password) -> bcrypt.hashSync password, bcrypt.genSaltSync(10)
