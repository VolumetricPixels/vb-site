module.exports =
  development:
    port: 3000
    dburl: 'mongodb://localhost/test'

  production:
    port: process.env.PORT || 80
    dburl: process.env.MONGOHQ_URL
