$(document).ready(function() {
	
	/*For freeing and fixing the cart */
	$('#free_cart, #fix_cart, #bar').hide();
		
	$('#free_cart').live('click', function(e) {
		var position_free = $('#sidebar').position();
		$('#sidebar').css({
			'left': position_free.left, 
			'top': position_free.top,
			'position': 'absolute'
		});
		$('#sidebar').draggable({disabled: false});
		$('#sidebar').css('cursor', 'move');
		$(this).hide();
		$('#fix_cart').show();
		e.preventDefault();
	});
	
	$('#fix_cart').live('click', function(e) {
		var position_fix = $('#sidebar').position();
		$('#sidebar').css({
			'left': position_fix.left, 
			'top': position_fix.top,
			'position': 'fixed'
		});
		$('#sidebar').draggable({ disabled: true});
		$('#sidebar').css('cursor', 'auto');
		$(this).hide();
		$('#free_cart').show();
		e.preventDefault();
	})
	
	$('.cal_toggle').click(function() {
		$('#free_cart').show();
		$('#bar').show();
	});
	
	$('#close_cal').click(function() {
		$('#free_cart').hide();
		$('#fix_cart').hide();
		$('#bar').hide();
		$('#sidebar').css({
			'left': '670px', 
			'top': '27px',
			'position': 'fixed',
			'cursor':'auto'
		});
		$('#sidebar').draggable({disabled: false});
	});

	$('.faq_a').hide();
	$('.faq_a:first').show();
	
	$('.faq_q').click(function(e) {
		$(this).next('.faq_a').slideToggle();
		$(this).next('.faq_a').siblings('.faq_a').slideUp();
		e.preventDefault();
	 });

	
//	$('#accordion').accordion();
	
	$('.for_tooltip').tooltip();
	
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
	$('.cart_toggle').click(function(e) {  
		$('div#sidebar').toggle('slide', {direction:'right'});
		e.preventDefault();
	});
		
	/*for search box toggling */
	$('.hide_search:first').hide();
	
	$('.hide_search:visible').live('click', function(e) {
		var current_label = $(this); 
		$('#search_container').slideToggle(300, function() {
			var the_other_label = $('.hide_search:hidden');
			current_label.hide();
			the_other_label.show();
		});
		e.preventDefault();
	})
	
	/*for toggling colors in the info/eval elements in the nav */
	
	$('#info_toggle').click( function(e) {  
		$(this).delay(800).css("color", "white");
		$('#eval_toggle').delay(800).css("color", "#7FEAFF");
	});
	
	$('#eval_toggle').click( function(e) {
		$(this).delay(800).css("color", "white");  
		$('#info_toggle').delay(800).css("color", "#7FEAFF");
	});
		
	/* For cart_add button disappear */
	$('.cart_add').live('click', function () {
		$(this).fadeOut();
		if($('div#sidebar').attr('style') === 'display:none;') {
			$('div#sidebar').show('slide', {direction:'right'});
		}
	});
	
	/*For hiding the cart */
	$('#hide_cart').click(function () {
		$('#sidebar').toggle('slide', {direction:'right'});
		return false;
	});
		
	/*Lock the courses header */	
	$(window).scroll(function() {
		var doc_position = $(document).scrollTop();
		if (doc_position >=279) {
			$('#first_row').css({
				'position' : 'fixed',
				'top' : '0px',
				'z-index' : '50'
			});
			$('#below_first_row').css({
				'position' : 'relative',
				'top' : '32px'
			});
			
		}
		if (doc_position <=279) {
			$('#first_row').css({
				'position' : '',
				'top' : ''
			});
			$('#below_first_row').css({
				'position' : '',
				'top' : ''
			});	
		}	
	});
	
	/* For the lightbox */
	var fade_speed = 600;
	
	$('#lightbox').hide();

	$('.eval_link a').live('click', function(e) {
		var url = $(this).attr('href') + ' .lightbox_back';
		$('#lightbox').load(url).fadeIn(700);
		e.preventDefault();
	});

	/*Lightbox close for evals */
	$('.lightbox_close a').live('click', function(e) {
		$(this).closest('div.lightbox_back').fadeOut(fade_speed);
		$('.lightbox').empty();
		//if the document's path is users/sign_in, then return to index upon click. Otherwise, prevent default. 
		e.preventDefault();
	});
	
	/*Lightbox close for calendar */
	$('.cal_lightbox_close a').live('click', function(e) {
		$('#courses_cal').fadeOut(fade_speed);
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

