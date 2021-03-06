$(document).ready(function() {
	
	/* Tooltips */	
	$('#search_day_like').tipTip();
	
	/* For hiding the sidebar at the beginning */
	$('#sidebar').hide();
	
	/*For setting the default text focus/blur (used in sign on page) */
	
	$('.default_text').live('focus', function(){
		$(this).val('');
		$(this).css('color', 'black');
	});

	$('.default_text').live('blur', function(){
		if ($(this).val() === '') 
			$(this).val($(this).attr('alt'));
	});

	/*For freeing and fixing the cart (within the calendar) */
	$('#free_cart, #fix_cart, #bar').hide();
	
	$('#sidebar').draggable({disabled: true});
		
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
		var cart_top_fix = position_fix.top - $(document).scrollTop();
		$('#sidebar').css({
			'left': position_fix.left, 
			'top': cart_top_fix,
			'position': 'fixed',
			'z-index': '120',
			//set opacity to 1 to counteract the automatic reduction in opacity set by disabling the draggability
			'opacity': '1'
		});
		$('#sidebar').draggable({ disabled: true });
		$('#sidebar').css('cursor', 'auto');
		$(this).hide();
		$('#free_cart').show();
		e.preventDefault();
	})
	
	/*For tying the free_cart and hide_cart options to the calendar */
	
	$('.cal_toggle').click(function() {
		setTimeout(function() {
			$('#free_cart').show();
			$('#bar').show();			
		}, 1000);
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
		$('#eval_toggle').delay(800).css("color", '#7FEAFF');
	});

	$('#eval_toggle').click( function(e) {
		$(this).delay(800).css("color", "white");  
		$('#info_toggle').delay(800).css("color", "#7FEAFF");
	});
		
	/* For cart_add button disappear */
	$('.cart_add').live('click', function () {
		$(this).fadeOut();
		//if the sidebar is hidden, show it
		if($('div#sidebar').attr('style').indexOf('display: none; ') !== -1) {
			$('div#sidebar').show('slide', {direction:'right'});
		}
	});
	
	/*For hiding the cart */
	$('#hide_cart').click(function () {
		$('#sidebar').toggle('slide', {direction:'right'});
		return false;
	});
		
	/*For locking the courses header */	
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
		if (doc_position <=278) {
			$('#first_row').css({
				'position' : '',
				'top' : '', 
				'z-index' : ''
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
	
	/*Lightbox open for anything in 'shadow' class */
		
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
		var nav_clone = $('#sb-nav').clone();
		$('#sb-nav').remove();
		$('#sb-title').prepend(nav_clone);
		$('#sb-nav').css({
			'position' : 'relative',
			'top' : '5px'
		});
		e.preventDefault();
	});
	
	/*If user is not signed in, flash pop up when they click on ratings view */
	
	$('#eval_not_signed_in').live('click', function() {
		alert("You must sign in with a yale.edu email to access ratings view");
		return false;
	});
	
	$('.about_ratings_switch').live('click', function() {
		$that = $(this);
		$('.lightbox_front').fadeOut('normal', function() {
			var url = $that.attr('href') + ' .lightbox_back';
			$('.lightbox#small').load(url).fadeIn(fade_speed);			
		}); 
		return false;
	});
	
	/*Highlight fade for 'ratings activated' flash notice */
	$('#flash_notice').highlightFade({color:'#1752c6',speed:1500, end:'#1F5168', iterator:'sinusoidal'}).delay(1750).fadeOut();
});