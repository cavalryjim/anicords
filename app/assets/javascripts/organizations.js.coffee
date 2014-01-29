# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$("#editAnimalModal").bind "close", ->
#  alert($('#animal_animal_type_id').val())

  
$(".org_animal_div").on "show", ->
  $(document).foundation()
  
  $(".regular_select").select2
    minimumResultsForSearch: 55
    width: "100%"

  $('#animal_breed_ids').select2
    placeholder: "breed"
    width: "100%"
    multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/breeds"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10
        at_id: $('#animal_animal_type_id').val()

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data
     
    initSelection: (element, callback) ->
      if $(element).val() isnt '[]'
        ids = JSON.parse($(element).val())
        breeds = ''
        $.each ids, (index, value) ->
          breeds = breeds + '&brd[]=' + value
   
        $.ajax("/remote_requests/breeds?"+breeds,
          dataType: "json"
        ).done (data) ->
          callback data        
  
  $('#animal_personality_type_ids').select2
    placeholder: "disposition"
    width: "100%"
    multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/personality_types"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10
        at_id: $('#animal_animal_type_id').val()

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data
     
    initSelection: (element, callback) ->
      if $(element).val() isnt '[]'
        ids = JSON.parse($(element).val())
        personality_types = ''
        $.each ids, (index, value) ->
          personality_types = personality_types + '&pt[]=' + value
   
        $.ajax("/remote_requests/personality_types?"+personality_types,
          dataType: "json"
        ).done (data) ->
          callback data
          
  $("#animal_gender").change ->
    $("#neutered_label").text( if ($("#animal_gender").val() == 'female') then ' Spayed?' else ' Neutered?')
    
  $(".datepicker").datepicker
    dateFormat: "yy-mm-dd"
    changeMonth: true
    changeYear: true
    
  $(".state_select").select2
    minimumResultsForSearch: 55
    width: "100%"
    matcher: (term, text) ->
      text.toUpperCase().indexOf(term.toUpperCase()) is 0