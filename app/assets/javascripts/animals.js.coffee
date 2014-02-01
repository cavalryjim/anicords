# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  
  #$("#animal_form").submit (event) ->
  #  $('#animal_breed_ids').val( fixIds($('#animal_breed_ids').val() ) )
  #  $('#animal_medication_ids').val( fixIds($('#animal_medication_ids').val() ) )
  #  $('#animal_medical_diagnosis_ids').val( fixIds($('#animal_medical_diagnosis_ids').val() ) )
  #  $('#animal_allergy_ids').val( fixIds($('#animal_allergy_ids').val() ) )
  #  $('#animal_personality_type_ids').val( fixIds($('#animal_personality_type_ids').val() ) )
    
  #fixIds = (messy_ids) ->
  #  if messy_ids == '[]' then messy_ids else "["+messy_ids.split('],')[1].split(',').toString()+"]"
 
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
    
  $('#animal_medication_ids').select2
    placeholder: "Add medications"
    width: "100%"
    multiple: true
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
     
    initSelection: (element, callback) ->
      if $(element).val() isnt '[]'
        ids = JSON.parse($(element).val())
        medications = ''
        $.each ids, (index, value) ->
          medications = medications + '&meds[]=' + value
   
        $.ajax("/remote_requests/medications?"+medications,
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
  
  $('#animal_breed_ids').select2
    #placeholder: "breed"
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
  
  $('#animal_association_service_provider_id').select2
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
    
  $(".upload_file").change -> validateFiles(this, 'file')
  $(".upload_picture").change -> validateFiles(this, 'picture')
  
  $("#animal_gender").change ->
    $("#neutered_label").text( if ($("#animal_gender").val() == 'female') then ' Spayed?' else ' Neutered?')
    
    
  #----------end of jquery dialog----------------------#  
  
  
  #$("form#animal_form").on("ajax:success", (event, data, status, response) ->
  #  $(".flash_alert").removeClass("hidden")
  #  $(".flash_alert").show().delay(2000).fadeOut()
  #  $("section.disabled").removeClass("disabled")
  # ).on("ajax:error", (event, response, error) ->
  #  alert "There was a problem.  Please try again later.")
  
  #$(".remove_file").change ->
  #  if @checked
  #    alert 'remove me, bitch'
  #  else
  #    alert 'no way, dude'
      
      
       
  #$("form#animal_form").bind 'ajax:remotipartSubmit', (event, xhr, settings) =>
  #  settings.dataType = "html *" 
  
      #$(".file_image").hide()
  #$("form#animal_form").trigger "submit.rails"
    
  
  #$("#animal_form").submit ->
  #  alert 'here'
  #  valuesToSubmit = $(this).serialize()
    #sumbits it to the given url of the form
    # you want a difference between normal and ajax-calls, and json is standard
  #  $.ajax(
  #    url: $(this).attr("action")
  #    data: valuesToSubmit
  #    dataType: "JSON"
  #  ).success (json) ->
     #act on result.
  #   alert("done")
  #   false # prevents normal behaviour
  
  

  
  #$('#animal_pedigree').fileupload
  #  dataType: "script"
  #  add: (e, data) ->
  #    types = /(\.|\/)(gif|jpe?g|png)$/i
  #    file = data.files[0]
  #    if types.test(file.type) || types.test(file.name)
  #      data.context = $(tmpl("template-upload", file))
  #      $('#animal_pedigree').append(data.context)
  #      data.submit()
  #    else
  #      alert("#{file.name} is not a gif, jpeg, or png image file")
  #  progress: (e, data) ->
  #    if data.context
  #      progress = parseInt(data.loaded / data.total * 100, 10)
  #      data.context.find('.bar').css('width', progress + '%')