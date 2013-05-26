module.exports = (router) ->

  router.get '/', 'index'
  router.get '/about', 'about'
  router.get '/contact', 'contact'

  router.get '/login', 'login'
  router.post '/login', 'login#index_post'
  router.get '/register', 'register'
  router.post '/register', 'register#index_post'
  router.get '/account', 'account'
  router.post '/account', 'account#index_post'

  router.get '/logout', 'logout'

  router.get '/bans', 'bans'
  router.get '/bans/:page', 'bans'
  router.get '/bans/show/:id', 'bans#show'

  router.get '/servers', 'servers'
  router.get '/servers/:page', 'servers'
  router.get '/servers/show/:id', 'servers#show'
