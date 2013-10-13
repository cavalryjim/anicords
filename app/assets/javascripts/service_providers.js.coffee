# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
         
  $("#service_provider_service_ids").chosen
    placeholder: "Select the services you provide"
    #multiple: true
    #ajax:
    #  url: "/services"
    #  dataType: "json"
    #  results: (data, page) ->
    #    results: $.map(data, (service, i) ->
    #      id: service.id
    #      text: service.name
   


  $(".service_provider_type").change ->
    if @checked
      $.get "/services?spt[]="+this.value, (data) -> 
        $.each data, (key, value) ->
          $("#service_provider_service_ids").append $("<option>",
            value: value.id
            text: value.text     
          )
    else
       $.get "/services?spt[]="+this.value, (data) -> 
         $.each data, (key, value) ->
           $("#service_provider_service_ids option[value='"+value.id+"']").val('').trigger("chosen:updated")
    #$("#service_provider_service_ids").trigger("chosen:updated");   
    #alert "here"   
    #$("#service_provider_service_ids").select2()
           
       
      
      
