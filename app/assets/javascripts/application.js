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
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .
  $(document).ready(function() { 
      $('#main_carousel_product').carousel();

      $('#main_avatar').bind('click', function() {
	    $('#file_field_button').trigger('click');
	  });

      $('#photo1_button').bind('click', function() {
	    $('#photo1_file_field').trigger('click');
	  });
	  $('#photo2_button').bind('click', function() {
	    $('#photo2_file_field').trigger('click');
	  });
	  $('#photo3_button').bind('click', function() {
	    $('#photo3_file_field').trigger('click');
	  });
	  $('#photo4_button').bind('click', function() {
	    $('#photo4_file_field').trigger('click');
	  });
	  $('#photo5_button').bind('click', function() {
	    $('#photo5_file_field').trigger('click');
	  });

	  $('#file_field_button').bind('change', function() {
    	$("#main_avatar").css("border", "5px solid #000000");
  	  });
  }); 