module.exports = (router) ->

  router.get '/', 'index'
  router.get '/about', 'about'
  router.get '/contact', 'contact'

  router.get '/bans', 'bans'
  router.get '/bans/:id', 'bans#show'
