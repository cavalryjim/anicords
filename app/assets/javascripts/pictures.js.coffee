# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# JDavis:  file upload field validation.
jQuery ->
  $("#new_image_uploader").submit (event) ->
    unless $("#image_uploader_image").val()
      event.preventDefault() 
      $("small.error").css("display", "block") 
      $("input.upload_picture").css("margin-bottom", 0)
    
  
  $("input.upload_picture").click ->
    $("small.error").css("display", "none") 
    $("input.upload_picture").css("margin-bottom", '1em')
