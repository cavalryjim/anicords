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
//= require foundation
//= require jquery.remotipart
//= require jquery.Jcrop
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation
//= require best_in_place
//= require jquery.easy-ticker.min
//= require jquery.sticky
//= require fnAddTr
//= require addtohomescreen
//= require jquery.datetimepicker
//= require select2
//= require_tree .


var orgTable;

$(function(){
  
  $(document).foundation({
    abide : {
      patterns: {
        // generic password: upper-case, lower-case, number/special character, and min 8 characters
        password : /(?=^.{8,}$).*$/
      }
    },
    equalizer: {
      equalize_on_stack: true
    }
  });
  
  //$(".sticky").sticky();
  
  //orgAnimalDataTable(); // JDavis: might need to call the function later.
  orgTable = $('#animal_table').dataTable({
    "aoColumnDefs": [
      { "aDataSort": [ 1 ], "aTargets": [ 1 ] }, 
      { "bSortable": false, "aTargets": [ 0, 7 ] },
      ],
    "sPaginationType": "foundation",
    "bStateSave": true
  }).show(); 
  
  $('#adoption_table').dataTable({
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 0 ] } ],
    "sPaginationType": "foundation",
    "bStateSave": true
  }).show();
  
  // JDavis: this was used to fade out the success messages.  Mike B. requested the messages persist.	
  setTimeout(function(){
   $("div.success").fadeOut("slow", function () {
   $("div.success").hide();
       });
  
  }, 2000);
  
  $( ".datepicker" ).datepicker({ 
  	dateFormat: 'yy-mm-dd',
  	changeMonth: true,
  	changeYear: true
  });
  
  
  $(".state_select").select2({ 
  	minimumResultsForSearch: 55, 
  	width: '100%',
    matcher: function(term, text) { return text.toUpperCase().indexOf(term.toUpperCase())==0; }
  });
  
  
  $(".best_in_place").best_in_place();
   
  //$('.full_page').css("min-height", $(window).height() - ( $("#header").height() + 1.5 * $("#nav_menu").height() + $("#footer").height() ) );
  $('.front_page_mainsection').css("min-height", $(window).height() - $("#top_bar").height() );
  $(".front_page_subsection").css("min-height",  $(window).height() );
  
  $(".no_default").click(function( event ) {
    event.preventDefault();
    //alert("hey");
  });
  
  //addToHomescreen.removeSession();
  var addtohome = addToHomescreen({
  	//debug: true	
  });
  
  $('.datetimepicker').datetimepicker({
  	formatTime: 'h:i a'
  });
  
  $(".regular_select").select2({ 
  	minimumResultsForSearch: 55, 
  	width: '100%'
  });
});

//= require turbolinks

function validateFiles(inputFile, type) {
  var maxExceededMessage = "This file exceeds the maximum allowed file size (5 MB)";
  
  if (type == 'picture') {
  	var extErrorMessage = "Only .bmp, .jpg, or .png files are allowed";
    var allowedExtension = ["bmp", "jpg", "jpeg", "png"];
  //} else {
  //  var extErrorMessage = "Only .pdf or .tif files are allowed";
  //  var allowedExtension = ["pdf", "tif", "tiff"];
  };
 
  var extName;
  var maxFileSize = $(inputFile).data('max-file-size');
  var sizeExceeded = false;
  var extError = false;
 
  $.each(inputFile.files, function() {
    if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = this.name.split('.').pop();
    if ((type == 'picture') && ($.inArray(extName, allowedExtension) == -1)) {extError=true;};
  });
  if (sizeExceeded) {
    window.alert(maxExceededMessage);
    $(inputFile).val('');
  };
 
  if (extError) {
    window.alert(extErrorMessage);
    $(inputFile).val('');
  };
}

  




$(function(){ $(document).foundation(); });
