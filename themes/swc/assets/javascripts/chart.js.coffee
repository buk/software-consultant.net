//= require raphael-min
//= require morris

# Reference jQuery
$ = jQuery

boolean = (value) ->
  return true if value=='true'
  return true if value=='1'
  false

# Adds plugin object to jQuery
$.fn.extend
  # Change pluginName to your plugin's name.
  chart: (options) ->
    # Default settings
    settings =
      debug: false

    # Merge default settings with options.
    settings = $.extend settings, options

    # Simple logger.
    log = (msg) ->
      console?.log msg if settings.debug

    # _Insert magic here._
    return @each ()->
      chart = switch $(this).data('type')
        when 'donut' then new Morris.Donut
          element: this
          data: $(this).data('values')
        when 'bar' then new Morris.Bar
          element: this
          data: $(this).data('values')
          xkey: $(this).data('xkey')
          ykeys: ($(this).data('ykeys') || '').split(',')
          labels: ($(this).data('labels') || '').split(',')
          hideHover: boolean($(this).data('hidehover'))

$ ->
  $('.chart').chart()
