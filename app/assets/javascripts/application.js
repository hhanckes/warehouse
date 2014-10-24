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
//= require jquery_nested_form
//= require bootstrap.min
//= require bootstrap-slider
//= require_tree .

$(document).ready(function() {
	$('#myButton').tooltip();
	
	$('.btn-loading').on('click', function () {
	  	$(this).attr("data-loading-text","Espera por favor...");
	  	$(this).button('loading');
	});
	
	$('.slider').slider().on('slide', function(ev){
		$('.boxes-count').html(ev.value);
	  });
	
	$('#div_count_1').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_1', 'bike-count');
	});
	$('#div_count_2').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_2', 'golf-count');
	});
	$('#div_count_3').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_3', 'ski-count');
	});
	$('#div_count_4').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_4', 'ac-count');
	});
	$('#div_count_5').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_5', 'carry-on-count');
	});
	$('#div_count_6').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_6', 'luggage-count');
	});
	$('#div_count_7').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_7', 'wardrobe-count');
	});
	$('#div_count_8').click(function(e){
	    if ($(e.target).is('select')) return;
	    update_selected_item('div_count_8', 'other-count');
	});
	$("#company").click(function(){
		if($("#company").is(":checked")) {
			$(".company-information").fadeIn();	
		} else {
			$(".company-information").fadeOut();
		}
	});
	$("#collect_later").click(function(){
		if($("#collect_later").is(":checked")) {
			$(".collect-later").fadeIn();	
		} else {
			$(".collect-later").fadeOut();
		}
	});
})

function update_selected_item(div_id, count_1) {
	if($('#'+div_id).attr('selected')) {
		$('#'+div_id).css( "background-color", "white" );
		$('#'+count_1).css( "display", "none" );
		$('#'+div_id).attr('selected', false);
		if(count_1 == 'other-count') {
			$(".other-details").fadeOut();
		}
	} else {
		$('#'+div_id).css( "background-color", "#FC8383" );
		$('#'+count_1).css( "display", "inline-block" );
		$('#'+div_id).attr('selected', true);
		if(count_1 == 'other-count') {
			$(".other-details").fadeIn();
		}
	}
}

function update_collection_day() {
	selected_delivery_date = $('#delivery-day').val()
	$("#collection-day > option").each(function() {
	    if(this.value <= selected_delivery_date) {
			$("#collection-day option[value='"+this.value+"']").remove();
		}
	});
}

function update_total_to_pay(checkbox, to_pay) {
	total = parseInt($('.total_to_pay').html().replace(/[^0-9]/g,''));
	if(checkbox.checked) {
		total = total + to_pay
	} else {
		total = total - to_pay		
	}
	$('.total_to_pay').html('$ '+addCommas(total));
}

function addCommas(nStr) {
	nStr += '';
	x = nStr.split(',');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + '.' + '$2');
	}
	return x1 + x2;
}

function add_to_osi_to_return(order_id, osi_id) {
	$('#return_'+osi_id).html('Espera por favor...')
	$.ajax({
        url: "/orders/"+order_id+"/add_osi_to_return_list/"+osi_id,
        type: "POST",
        dataType: "html",
		headers: {
		   'X-Transaction': 'POST Timezone',
		   'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
        data: { 'id': order_id, 'order_storage_item_id' : osi_id }, 
		success: function(data) {
			var json = JSON.parse(data)
			if(json['return_requested']) {
					$('#return_'+osi_id).html('Eliminar de items a devolver');
					$('#return_'+osi_id).attr('class', 'btn btn-primary btn-xs');
				} else {
					$('#return_'+osi_id).html('Agregar a items para devolver');
					$('#return_'+osi_id).attr('class', 'btn btn-default btn-xs');
				}
			$('#items_requested').html(json['items_requested']);
        }
    });
}