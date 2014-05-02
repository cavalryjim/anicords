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
//= require jquery.Jcrop
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation
//= require best_in_place
//= require jquery.easy-ticker.min
//= require_tree .

$(function(){
  
  $(document).foundation()
  .foundation('abide', {
    patterns: {
      // generic password: upper-case, lower-case, number/special character, and min 8 characters
      password : /(?=^.{8,}$).*$/

    }
   });
   
  
  $('#animal_table').dataTable({
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 0 ] } ],
    "sPaginationType": "foundation",
    "bStateSave": true
  }).show();
  
  $('#adoption_table').dataTable({
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 0 ] } ],
    "sPaginationType": "foundation",
    "bStateSave": true
  }).show();
  
	
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
  
  $(".regular_select").select2({ minimumResultsForSearch: 55, width: '100%'});
  
  $(".state_select").select2({ 
  	minimumResultsForSearch: 55, 
  	width: '100%',
    matcher: function(term, text) { return text.toUpperCase().indexOf(term.toUpperCase())==0; }
  });
  
  //$('#org_animal_edit_div').on('show', function() {
  	//$(document).foundation();
    //alert("ehool");
    //$(".regular_select2").select2("destroy");
    //$(".org_regular_select2").select2({ minimumResultsForSearch: 55, width: '100%'});
    //$(".org_animal_breed").select2({
    //  data:[{id:0,text:'enhancement'},{id:1,text:'bug'},{id:2,text:'duplicate'},{id:3,text:'invalid'},{id:4,text:'wontfix'}]
    //});
  //});
  
  $('.front_page_callout').click(function() {
    $('#registerSigninModal').foundation('reveal', 'open');
  });
  
  $(".best_in_place").best_in_place();
  
  $("#test_scroll").click(function(){
  	var num = $("#target_scroll").offset().top;
  	//alert(num);
  	$("html,body").animate({
  	  scrollTop:$("#target_scroll").offset().top},"500"
  	);
  	return false;
  });
  
  $('.full_page').height($(window).height() - $("#top_bar").height());
  $('.front_page_subsection').height($(window).height());

});




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

