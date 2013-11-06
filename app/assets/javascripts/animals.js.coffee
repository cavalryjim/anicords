# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  
  $('#animal_medical_diagnosis_ids').select2
    width: "100%"
    placeholder: "Add medical diagnosis"
    multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/medical_diagnoses"
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
        diagnoses = ''
        $.each ids, (index, value) ->
          diagnoses = diagnoses + '&md[]=' + value
   
        $.ajax("/medical_diagnoses?"+diagnoses,
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
      url: "/medications"
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
   
        $.ajax("/medications?"+medications,
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
      url: "/allergies"
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
   
        $.ajax("/allergies?"+allergies,
          dataType: "json"
        ).done (data) ->
          callback data
          
  $('#animal_food_ids').select2
    #placeholder: "Add allergies"
    width: "100%"
    #multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/foods"
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
        food = ''
        $.each ids, (index, value) ->
          food = food + '&fd=' + value
   
        $.ajax("/foods?"+food,
          dataType: "json"
        ).done (data) ->
          callback data
    
  $('#animal_shampoo_id').select2
    #placeholder: "Add allergies"
    width: "100%"
    #multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/shampoos"
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
   
        $.ajax("/shampoos?shpo="+ids,
          dataType: "json"
        ).done (data) ->
          callback data
          
  $('#animal_treat_id').select2
    #placeholder: "Add allergies"
    width: "100%"
    #multiple: true
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/treats"
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
   
        $.ajax("/treats?trt="+ids,
          dataType: "json"
        ).done (data) ->
          callback data
  
  $('#animal_vitamin_id').select2
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
    width: "100%"
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/service_providers"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10

      results: (data, page) -> 
        results: data
        
  $('#animal_vaccination_vaccination_id').select2
    width: "100%"
    id: (obj) ->
      obj.id # use slug field for id

    ajax: # instead of writing the function to execute the request we use Select2's convenient helper
      url: "/vaccinations"
      dataType: "json"
      data: (term, page) ->
        term: term # search term
        page_limit: 10

      results: (data, page) -> 
        results: data
    
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