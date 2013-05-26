#= require bootstrap
#= require moment
#= require form/jquery.form

$ ->
  # https://gist.github.com/spilliams/2697774
  $(".footer, .push").height $(".footer .row").height() + "px"
  $(".wrapper").css "margin-bottom": (-1 * $(".footer .row").height()) + "px"
  window.onresize = ->
    $(".footer, .push").height $(".footer .row").height() + "px"
    $(".wrapper").css "margin-bottom": (-1 * $(".footer .row").height()) + "px"

  # Turn .date into dates
  $(".date").html (index, oldHtml) -> moment(oldHtml).format('MMMM Do YYYY, h:mm a')

window.Form = class Form
  constructor: (formName, @refresh=yes) ->
    @el = $ "##{formName}"
    @errorEl = $ "##{formName}Errors"

    @el.ajaxForm
      error: (xhr) =>
        @errorEl.find('.alert').alert 'close'
        @error xhr.responseText

      success: =>
        if @refresh
          window.location.reload()

  error: (error) ->
    @errorEl.append '<div class="alert alert-error">' + error + '</div>'
