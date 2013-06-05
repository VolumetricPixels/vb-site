async = require 'async'
bcrypt = require 'bcrypt'

Ban = require '../app/models/ban'
Player = require '../app/models/player'
Server = require '../app/models/server'
User = require '../app/models/user'

module.exports = (done) ->
  p =
    albireox: new Player
      name: 'albireox'
    dzineit: new Player
      name: 'dzineit'
    maxorq: new Player
      name: 'Maxorq'
    dyrus: new Player
      name: 'Dyrus'

  s =
    gemcraft: new Server
      ip: 'play.gemcraft.net'
      desc: 'GemCraft!!!!! gems are truly outrageous'

    obsidiancraft: new Server
      ip: 'play.obsidiancraft.net'
      desc: 'ObsidianCraft || worst server NA'
      strictness: 3

  bans = [
    new Ban
      player: p.albireox
      server: s.gemcraft
      reason: 'advertising obsidiancraft and griefing'
      issuer: p.dyrus
      date: new Date("2013-04-03 13:23:15")
      end: new Date("2013-04-04 13:23:15")

    new Ban
      player: p.albireox
      server: s.gemcraft
      reason: 'this guy is annoying'
      issuer: p.dyrus
      date: new Date("2012-05-03 13:23:15")
      end: new Date("2013-05-25 13:23:15")

    new Ban
      player: p.albireox
      server: s.gemcraft
      reason: 'this guy is super annoying'
      issuer: p.dyrus
      date: new Date("2012-06-03 13:23:15")
      end: null
  ]

  u =
    test: new User
      username: 'test'
      email: 'test@gmail.com'
      password: hash 'passw0rd'
      players: [p.albireox]
      servers: [s.obsidiancraft]

  items = []

  items.push v for own k, v of p
  items.push v for own k, v of s
  items.push ban for ban in bans
  items.push v for own k, v of u

  async.forEach items, (item, callback) ->
    item.save callback
  , done

hash = (password) -> bcrypt.hashSync password, bcrypt.genSaltSync(10)
