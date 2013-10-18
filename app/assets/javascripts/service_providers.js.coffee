# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
      
  $(".service_provider_type").change ->
    if @checked
      parent = this.value
      $.get "/services?spt[]="+parent, (data) -> 
        $.each data, (key, value) ->
          $("#available_services").append $("<li class='child_of_"+parent+"'><label for='service_"+value.id+"'><input id='service_"+value.id+"' name='service_provider[service_ids][]' type='checkbox' value="+value.id+"/> <span class='custom checkbox'></span>"+value.text+"</label></li>")
    else
       $("li.child_of_"+this.value).remove()
    
           
   
      
