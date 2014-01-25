# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$("#editAnimalModal").bind "close", ->
#  alert($('#animal_animal_type_id').val())

  
$(".org_animal_div").on "show", ->
  $(document).foundation()
  
  #$("#animal_animal_type_id").change ->
    #alert "Handler for .change() called."
   # alert $('#animal_animal_type_id').val()
    
  #alert("ehool");
  $(".regular_select").select2
    minimumResultsForSearch: 55
    width: "100%"

  $("#animal_breed_id").select2 
    placeholder: "breed"
    width: "100%"
    #multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/breeds"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        at_id: $('#animal_animal_type_id').val()
        page_limit: 10

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data
     
    initSelection: (element, callback) ->
      if $(element).val() isnt ''
        ids = $(element).val()
   
        $.ajax("/remote_requests/breeds?brd="+ids,
          dataType: "json"
        ).done (data) ->
          callback data    
  
