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
//= require jquery_ujs
//= require turbolinks
//= require jquery_nested_form
//= require bootstrap.min
//= require bootstrap-slider
//= require_tree .

$(document).ready(function() {
	$('.slider').slider().on('slide', function(ev){
		$('.boxes-count').html(ev.value);
	  });;
	
	$('#div_count_1').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_1', 'count_1');
	});
})


function update_selected_item(div_id, count_1) {
	if($('#'+div_id).attr('selected')) {
		$('#'+div_id).css( "background-color", "white" );
		$('#'+count_1).css( "display", "none" );
		$('#'+div_id).attr('selected', false)
	} else {
		$('#'+div_id).css( "background-color", "#0e90d2" );
		$('#'+count_1).css( "display", "inline-block" );
		$('#'+div_id).attr('selected', true)
	}
}