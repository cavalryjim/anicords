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
  
  $('#household_association_provider_id').select2
    placeholder: "service provider"
    width: "100%"
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/service_providers"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        city: $('#city_term').val()
        state: $('#state_term').val()
        zip: $('#zip_term').val()
        provider_type: $('#provider_type_term').val()
        page_limit: 10

      results: (data, page) -> 
        results: data

