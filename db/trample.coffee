async = require 'async'

module.exports = (done) ->
  async.forEach [
    require('../app/models/ban'),
    require('../app/models/player'),
    require('../app/models/server')
  ], (item, callback) ->
    item.collection.drop callback
  , done
