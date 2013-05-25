SendGrid = require('sendgrid').SendGrid
sendgrid = new SendGrid process.env.SENDGRID_USERNAME, process.env.SENDGRID_PASSWORD

module.exports =
  send: (opts, cb) ->
    sendgrid.send opts, cb
