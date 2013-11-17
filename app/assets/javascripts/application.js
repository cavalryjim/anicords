// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.remotipart
//= require foundation
//= require select2
//= require turbolinks
//= require_tree .

$(function(){
  
  $(document).foundation()
  .foundation('abide', {
    patterns: {
      // generic password: upper-case, lower-case, number/special character, and min 8 characters
      password : /(?=^.{8,}$).*$/

    }
   }); 
   
  //document.addEventListener("page:load", function(){
    //Foundation.libs.dropdown.events();
    //alert("here");
    //$(document).foundation('dropdown', 'off');
    //$(document).foundation('dropdown');
  //});
  
	
  setTimeout(function(){
    $("div.success").fadeOut("slow", function () {
    $("div.success").hide();
        });
 
  }, 2000);
  
  $( ".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
  
  $(".regular_select").select2({ minimumResultsForSearch: 55, width: '100%'});
	

});

