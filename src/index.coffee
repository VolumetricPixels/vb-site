app = require('express')()

require('./routes')(app)

app.listen 3000
