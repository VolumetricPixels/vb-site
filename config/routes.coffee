module.exports = (router) ->

  router.get '/', 'index'
  router.get '/about', 'about'

  router.get '/bans', 'bans'
  router.get '/bans/:id', 'bans#show'
