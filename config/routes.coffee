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
  router.post '/logout', 'logout#index_post'

  router.get '/bans', 'bans'
  router.get '/bans/:id', 'bans#show'

  router.get '/players', 'players'
  router.get '/players/:name', 'players#show'

  router.get '/servers', 'servers'
  router.get '/servers/:id', 'servers#show'

  # Query
  router.all '/query', 'query'
  router.all '/query/bans/:action', 'query#bans'
  router.all '/query/data/:action', 'query#data'
  router.all '/query/players/:action', 'query#players'
  router.all '/query/servers/:action', 'query#servers'

  router.all '*', '404'
