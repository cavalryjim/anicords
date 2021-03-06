# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
      
  $(".service_provider_type, .service_provider_type_modal").change ->
    if @checked
      parent = this.value
      $.get "/remote_requests/services?spt[]="+parent, (data) -> 
        $.each data, (key, value) ->
          if $(".reveal-modal").is(":visible")
            $("#available_services_modal").append $("<li class='child_of_"+parent+"'><label for='service_"+value.id+"'><input id='service_"+value.id+"' name='service_provider[service_ids][]' type='checkbox' value="+value.id+" /> <span class='custom checkbox'></span>"+value.text+"</label></li>")
          else
            $("#available_services").append $("<li class='child_of_"+parent+"'><label for='service_"+value.id+"'><input id='service_"+value.id+"' name='service_provider[service_ids][]' type='checkbox' value="+value.id+" /> <span class='custom checkbox'></span>"+value.text+"</label></li>")
    else
       $("li.child_of_"+this.value).remove()
    
           
   
  $(".veterinarian, .veterinarian_modal").change ->
    if @checked
      $("#veterinarian_list").removeClass("hidden") unless $(".reveal-modal").is(":visible")
    else
      $("#veterinarian_list").addClass("hidden")
      
      
      
  $("#sp_client_list_table").dataTable().show()
  $("#sp_current_clients_table").dataTable().show()
  
  
  
  