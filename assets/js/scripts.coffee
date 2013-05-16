$ ->
  # https://gist.github.com/spilliams/2697774
  $(".footer, .push").height $(".footer .row").height() + "px"
  $(".wrapper").css "margin-bottom": (-1 * $(".footer .row").height()) + "px"
  window.onresize = ->
    $(".footer, .push").height $(".footer .row").height() + "px"
    $(".wrapper").css "margin-bottom": (-1 * $(".footer .row").height()) + "px"

  # Turn .date into dates
  $(".date").html (index, oldHtml) -> moment(oldHtml).format('MMMM Do YYYY, h:mm a')
