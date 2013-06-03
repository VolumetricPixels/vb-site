module.exports =
  test:
    port: 3000
    dburl: 'mongodb://localhost/test'
    fastAssets: no

  development:
    port: 3000
    dburl: 'mongodb://localhost/test'
    fastAssets: no

  production:
    port: process.env.PORT || 80
    dburl: process.env.MONGOHQ_URL
    fastAssets: yes
