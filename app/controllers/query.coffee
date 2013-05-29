module.exports =
  index: (req, res) ->
    res.redirect '/'

  bans: (req, res) ->
    switch req.params.action
      when 'ban'
        return
      else
        res.json 422, error: 'Unspecified or unknown action.'

  data: (req, res) ->
    switch req.params.action
      when 'getOnline'
        return
      when 'update'
        return
      when 'isPremium'
        return
      else
        res.json 422, error: 'Unspecified or unknown action.'

  players: (req, res) ->
    switch req.params.action
      when 'getBanCount'
        return
      when 'checkPermanentGlobalBan'
        return
      else
        res.json 422, error: 'Unspecified or unknown action.'

  servers: (req, res) ->
    switch req.params.action
      when 'isTrusted'
        return
      when 'isOnline'
        return
      else
        res.json 422, error: 'Unspecified or unknown action.'
