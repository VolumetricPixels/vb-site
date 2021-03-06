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
  router.post '/servers', 'servers#index_post'
  router.get '/servers/new', 'servers#new'
  router.post '/servers/new', 'servers#new_post'
  router.get '/servers/:ip', 'servers#show'
  router.get '/servers/:ip/edit', 'servers#edit'
  router.post '/servers/:ip/edit', 'servers#edit_post'

  # Query
  router.get '/query', 'query'
  router.get '/query/isBanned', 'query#isBanned'
  router.post '/query/ban', 'query#ban_post'
  router.post '/query/unban', 'query#unban_post'
  router.all '/query/*', 'query'

  router.all '*', '404'
