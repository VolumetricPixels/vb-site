app = require('express')()

app.get '/', (req, res) ->
  res.send 'Hello, world!'
