# https://gist.github.com/spilliams/2697774
$(".footer, .push").height $(".footer .row").height() + "px"
$(".wrapper").css "margin-bottom": (-1 * $(".footer .row").height()) + "px"
window.onresize = ->
  $(".footer, .push").height $(".footer .row").height() + "px"
  $(".wrapper").css "margin-bottom": (-1 * $(".footer .row").height()) + "px"
