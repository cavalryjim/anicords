# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#jQuery ->
  
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