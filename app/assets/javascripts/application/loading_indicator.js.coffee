$(document).ajaxStart(->
  $('#loading-indicator').show()
).ajaxStop ->
  $('#loading-indicator').hide()
