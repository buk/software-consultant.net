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
    if typeof(piwikTracker) != 'undefined'
      curpage = $('#projects .nav .active a').text()
      query = $('#projects table').data('query')
      title = "Projekte"
      if query
        title = title + " (" + query + ")"
      title = title + "/" + curpage
      try
        piwikTracker.trackPageView(title)
      catch error
        $.error(error)
    false

 $('#search').live 'ajax:success', (evt, data) ->
    $('#projects').html(data)
    if typeof(piwikTracker) != 'undefined'
      totalcount = $('#projects table').data('total-count')
      query = $('#projects table').data('query')
      try
        piwikTracker.trackSiteSearch(query, false, totalcount)
      catch error
        $.error(error)
    false

