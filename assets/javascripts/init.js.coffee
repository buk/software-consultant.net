$ ->
  $('#language').modal('show')

  max = 0
  $('.carousel .item').each ->
    if $(this).height()>max
      max = $(this).height()
  $('.carousel .item').height(max)

  $('.carousel .item:first').addClass('active')
  $('.carousel').carousel()

  $('#projects .nav a').live 'ajax:success', (evt, data) ->
    $('#projects').html(data)

 $('#search').live 'ajax:success', (evt, data) ->
    $('#projects').html(data)
