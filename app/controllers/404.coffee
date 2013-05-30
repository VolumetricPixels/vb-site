module.exports =
  index: (req, res) ->
    res.status 404
    res.render 'layouts/404'
