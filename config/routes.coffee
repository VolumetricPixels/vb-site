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
  router.get '/query', 'query'
  router.get '/query/isGlobalBanned', 'query#isGlobalBanned'
  router.post '/query/ban', 'query#ban_post'
  router.post '/query/unban', 'query#unban_post'
  router.all '/query*', 'query'

  router.all '*', '404'
