module.exports = (router) ->

  router.route '/', 'index'
  router.route '/about', 'about'

  router.route '/bans', 'bans'
