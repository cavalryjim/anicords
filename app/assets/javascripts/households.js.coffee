# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  #$("#stepsOverviewModal").foundation( "reveal", "open")
  
  #$('#service_provider').autocomplete
  #  source: $('#service_provider').data('autocomplete-source')
  #  select: (event, ui) ->
      #alert(ui.item.label)
  #    $('#service_provider_id').val(ui.item.value)
  #    $('#service_provider').val(ui.item.label)
  #    event.preventDefault()

  #$('#provider_reveal_button').click ->
  #  $('#service_provider').focus

    
  blink_border = (elem, times, speed) ->
    if times > 0 or times < 0
      if $(elem).hasClass("blink_border")
        $(elem).removeClass "blink_border"
      else
        $(elem).addClass "blink_border"
    clearTimeout ->
      blink_border elem, times, speed
  
    if times > 0 or times < 0
      setTimeout (->
        blink_border elem, times, speed
      ), speed
      times -= .5
        
  $(window).bind "load", ->
    #alert 'window loaded'
    blink_border ".animal_alert", 1, 600
    
  $("#household_news").easyTicker(
    direction: 'down'
    interval: 4000
    speed: 'slow'
    visible: 6
  ).show()

