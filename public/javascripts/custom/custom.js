$(document).ready(function() {
	
	$('#sidebar').hide();

 	/*horizontal bars in the courses table */	
	$('.other_rows:even').addClass('zebra');
	
	$('#courses_body').live('change', function() { /*uses 'live' so that javascript applies to html that is inserted */
		$('.descrip_body').hide();
		$('.other_rows:even').addClass('zebra'); /*horizontal bars in the courses table */	
	});
	
	/*for toggling course descrip */
	$('.course_name_click').live('click', function(e) {
		$(this).closest('div').next().slideToggle('slow');
		e.preventDefault();
	 });
	
	/*for shopping cart toggling */
	$('#cart_toggle').live('click', function(e) {  
		$('div#sidebar').toggle(500);
		e.preventDefault();
	});
	
	/*for toggling colors in the info/eval elements in the nav */
	
	$('#info_toggle').live('click', function(e) {  
		$(this).delay(800).css("color", "white");
		$('#eval_toggle').delay(800).css("color", "#7FEAFF");
	});
	
	$('#eval_toggle').live('click', function(e) {
		$(this).delay(800).css("color", "white");  
		$('#info_toggle').delay(800).css("color", "#7FEAFF");
	});
		
	
	/* For cart_add button disappear */
	$('.cart_add').live('click', function () {
		$(this).fadeOut();
		$('div#sidebar').show(500);
	});
	
	/*For hiding the cart */
	$('#hide_cart').click(function () {
		$('#sidebar').hide(500);
		return false;
	})
	
	
	/* For the lightbox */
	var fade_speed = 600;
	
	$('#lightbox').hide();

	$('.eval_link a').live('click', function(e) {
		var url = $(this).attr('href') + ' .lightbox_back';
		$('#lightbox').load(url).fadeIn(700);
		e.preventDefault();
	});
	
	$('.lightbox_close a').live('click', function(e) {
		$(this).closest('div.lightbox_back').fadeOut(fade_speed);
		$('.lightbox').empty();
		e.preventDefault();
	});
		
	$('.shadow').live('click', function(e) {
		var url = $(this).attr('href') + ' .lightbox_back';
		$('.lightbox#small').load(url).fadeIn(fade_speed);
		e.preventDefault();
	});
	
	/* For fancy_box that holds course evaluations */
	
	$('a.eval_shadow').live('click', function(e) {
		var url = $(this).attr('href'); // Our URL
		Shadowbox.open({
			content:    url,
			player:     "iframe",
			height:     600,
			width:      900,
			title: 		"Course Evaluation"
           });
		e.preventDefault();
		});

});

