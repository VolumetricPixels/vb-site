describe 'player', ->
  Player = require '../../app/models/player'
  Server = require '../../app/models/server'

  describe '#countBans', ->
    it 'should correctly count the number of bans of a player', ->
      Player.getPlayer 'albireox', (e, player) ->
        player.countBans {player: player._id}, (err, count) ->
          count.should.equal 3

    it 'should return 0 if a player has never been banned', ->
      Player.getPlayer 'ollie', (e, player) ->
        player.countBans {player: player._id}, (err, count) ->
          count.should.equal 0

  describe '#isBanned', ->
    it 'should have 1 ban player banned with strictness 1', ->
      Server.findOne {strictness: 1}, (e, server) ->
        Player.getPlayer 'albireox', (e, player) ->
          player.isBanned server, (err, res) ->
            res.should.equal yes

    it 'should not have 1 ban player banned with strictness 3', ->
      Server.findOne {strictness: 3}, (e, server) ->
        Player.getPlayer 'albireox', (e, player) ->
          player.isBanned server, (err, res) ->
            res.should.equal yes
