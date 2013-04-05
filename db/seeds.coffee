async = require 'async'

Ban = require '../app/models/ban'
Player = require '../app/models/player'
Server = require '../app/models/server'

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

  async.parallel [
    (cb) -> albireox.save cb,
    (cb) -> dzineit.save cb,
    (cb) -> maxorq.save cb,
    (cb) -> dyrus.save cb,

    (cb) -> gemcraft.save cb,
    (cb) -> obsidiancraft.save cb,
  ], (err, results) ->
    async.forEach bans, (item, callback) ->
      item.save callback
    , done
