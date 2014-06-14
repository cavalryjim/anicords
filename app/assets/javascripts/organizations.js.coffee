# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$("#editAnimalModal").bind "close", ->
#  alert($('#animal_animal_type_id').val())


#$("#org_news").ticker
#  htmlFeed: false
#  ajaxFeed: true
#  feedUrl: window.location.pathname + ".rss"
  #feedUrl: "http://feeds.abcnews.com/abcnews/topstories"
#  feedType: "xml"
#  displayType: 'fade'
#  titleText: 'News'


#$("#org_news").rssfeed window.location.href + ".atom"
#  snippet: true
#, (e) ->
#  $(e).find("div.rssBody").vTicker showItems: 2
#  return

$("#org_news").easyTicker(
  visible: 1
  interval: 4000
).show()

$("#import_button").click (event) ->
  event.preventDefault()
  
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
  
  $('#animal_medical_diagnosis_ids').select2
    width: "100%"
    placeholder: "Add medical diagnosis"
    multiple: true
    id: (obj) ->
      obj.id 

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/medical_diagnoses"
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
        diagnoses = ''
        $.each ids, (index, value) ->
          diagnoses = diagnoses + '&md[]=' + value
   
        $.ajax("/remote_requests/medical_diagnoses?"+diagnoses,
          dataType: "json"
        ).done (data) ->
          callback data
    
          
  $('#animal_allergy_ids').select2
    placeholder: "Add allergies"
    width: "100%"
    multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/allergies"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data
     
    initSelection: (element, callback) ->
      if $(element).val() isnt '[]'
        ids = JSON.parse($(element).val())
        allergies = ''
        $.each ids, (index, value) ->
          allergies = allergies + '&alg[]=' + value
   
        $.ajax("/remote_requests/allergies?"+allergies,
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
          
    
  $(".datepicker").datepicker
    dateFormat: "yy-mm-dd"
    changeMonth: true
    changeYear: true
    
  $(".state_select").select2
    minimumResultsForSearch: 55
    width: "100%"
    matcher: (term, text) ->
      text.toUpperCase().indexOf(term.toUpperCase()) is 0
  
  $('#animal_food_id').select2
    placeholder: "pet food brand"
    width: "100%"
    #multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/foods"
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
   
        $.ajax("/remote_requests/foods?fd="+ids,
          dataType: "json"
        ).done (data) ->
          callback data
    
  $('#animal_shampoo_id').select2
    placeholder: "pet shampoo brand"
    width: "100%"
    #multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/shampoos"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data
     
    initSelection: (element, callback) ->
      if $(element).val() isnt ''
        ids = $(element).val()
   
        $.ajax("/remote_requests/shampoos?shpo="+ids,
          dataType: "json"
        ).done (data) ->
          callback data
      
  $('#animal_treat_id').select2
    placeholder: "pet treat brand"
    width: "100%"
    #multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/treats"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data
     
    initSelection: (element, callback) ->
      if $(element).val() isnt ''
        ids = $(element).val()
   
        $.ajax("/remote_requests/treats?trt="+ids,
          dataType: "json"
        ).done (data) ->
          callback data
  
  $('#animal_vitamin_id').select2
    placeholder: "pet vitamin brand"
    width: "100%"
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/vitamins"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10

      results: (data, page) -> 
        results: data
     
    initSelection: (element, callback) ->
      if $(element).val() isnt ''
        ids = $(element).val()
   
        $.ajax("/remote_requests/vitamins?vit="+ids,
          dataType: "json"
        ).done (data) ->
          callback data 

  $('#animal_medication_medication_id').select2
    placeholder: "medication"
    width: "100%"
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/medications"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10

      results: (data, page) -> # parse the results into the format expected by Select2.
        # since we are using custom formatting functions we do not need to alter remote JSON data
        results: data
        
  $('#animal_vaccination_vaccination_id').select2
    placeholder: "vaccination"
    width: "100%"
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/vaccinations"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10

      results: (data, page) -> 
        results: data
  
  # JDavis: jquery dialog form for capturing feeding information
  updateTips = (t) ->
    tips.text(t).addClass "ui-state-highlight"
    setTimeout (->
      tips.removeClass "ui-state-highlight", 1500
    ), 500
  checkNumeric = (n) ->
    unless $.isNumeric n.val() 
      n.addClass "ui-state-error"
      updateTips "enter number, such as 2 cups"
      false
    else
      true
      
  checkValue = (v) ->
    unless v.val()
      v.addClass "ui-state-error"
      updateTips "all fields are required"
      false
    else
      true
      
  amount = $("#feeding_volume")
  measure = $("#feeding_measure")
  frequency = $("#feeding_frequency")
  allFields = $([]).add(amount).add(measure).add(frequency)
  tips = $(".validateTips")
  
  $("#feeding_dialog").dialog
    autoOpen: false
    height: 250
    width: 350
    modal: true
    buttons:
      "Done": ->
        bValid = true
        text = ""
        allFields.removeClass "ui-state-error"
        bValid = bValid and checkNumeric(amount)
        bValid = bValid and checkValue(measure)
        bValid = bValid and checkValue(frequency)
        if bValid
          $("#animal_volume_per_serving").val amount.val()
          $("#animal_serving_measure").val measure.val()
          $("#animal_servings_per_day").val frequency.val()
          text = amount.val() + ' ' + measure.val() + ' / ' + frequency.val() + ' x per day'
          $("#feeding_display").val text
          $(this).dialog "close"

      Cancel: ->
        $(this).dialog "close"

    close: ->
      allFields.val("").removeClass "ui-state-error"

  $("#feeding_display").click ->
    $("#feeding_dialog").dialog "open"
        
  
  $('#animal_registration_club_id').select2
    placeholder: "registration club"
    minimumResultsForSearch: 15
    width: "100%"
    #multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/remote_requests/registration_clubs"
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
   
        $.ajax("/remote_requests/registration_clubs?clb="+ids,
          dataType: "json"
        ).done (data) ->
          callback data    
  
  # JDaivs: move data to another form and submit it.
  $("#add_vaccination").click (event) -> 
    event.preventDefault()
    if $('#dialog_vaccination_id').val() and $('#dialog_vaccination_date').val()
      $("#animal_vaccination_vaccination_id").val( $('#dialog_vaccination_id').val() )
      $("#animal_vaccination_vaccination_date").val( $('#dialog_vaccination_date').val() )
      $("#animal_vaccination_vaccination_id").val( $('#dialog_vaccination_id').val() )
      $("#animal_vaccination_tag_number").val( $('#dialog_tag_number').val() )
      $("#animal_vaccination_form").submit()
    else
      alert "Select a vaccination and date."
      
  # JDaivs: move data to another form and submit it.
  $("#add_medication").click (event) ->
    event.preventDefault()
    if $('#dialog_medication_id').val() 
      $("#animal_medication_medication_id").val( $('#dialog_medication_id').val() )
      $("#animal_medication_volume").val( $('#dialog_medication_volume').val() )
      $("#animal_medication_route").val( $('#dialog_medication_route').val() )
      $("#animal_medication_interval").val( $('#dialog_medication_interval').val() )
      $("#animal_medication_form").submit()
    else
      alert "Select a medication."
      
  $("#animal_gender").change ->
    $("#neutered_label").text( if ($("#animal_gender").val() == 'female') then ' Spayed?' else ' Neutered?')
      
  $("#animal_neutered").change ->
     $(".neuter_disable").prop('disabled', !$("#animal_neutered").is(':checked'))
  
  $("#animal_pedigreed").change ->
     $(".pedigree_disable").prop('disabled', !$("#animal_pedigreed").is(':checked'))
  
  $("#animal_microchipped").change ->
     $(".microchip_disable").prop('disabled', !$("#animal_microchipped").is(':checked'))
     
  $("img#weight_details").click (event) ->
    if $("#animal_weight_table_div").is(":hidden")
      $("#animal_weight_table_div").slideDown()
      $("img#weight_details").attr "src", "/img/details_close.png"
    else
      $("#animal_weight_table_div").slideUp()
      $("img#weight_details").attr "src", "/img/details_open.png"
      
  $(window).load -> 
    #$(".tabs-content").show()
    $(".tabs-content #panel2").removeClass "active"
    