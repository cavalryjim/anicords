# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  
  $('#service_provider').autocomplete
    source: $('#service_provider').data('autocomplete-source')
    select: (event, ui) ->
      #alert(ui.item.label)
      $('#service_provider_id').val(ui.item.value)
      $('#service_provider').val(ui.item.label)
      event.preventDefault()
