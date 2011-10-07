$(document).ready(function() {
	
	$('.other_rows:even').addClass('zebra'); /*horizontal bars in the courses table */
	
	$('.descrip_body').hide();
	
	$('.course_name_click').click(function() {
		$(this).closest('div').next().slideToggle('slow');
		return false;
	 });
	
	$('.toggle_link_hide').live('click', function(e) {  /*for search box toggling */
		$(this).next('div').slideToggle('slow');
		$(this).replaceWith('<a href=\'\' class=\"toggle_link_show\">Show<img id=\"arrow\" src=\"/images/down_arrow.gif\">');
		e.preventDefault();
	 });
	
	$('.toggle_link_show').live('click', function(e) {  /*for search box toggling */
		$(this).next('div').slideToggle('slow');
		$(this).replaceWith('<a href=\'\' class=\"toggle_link_hide\">Hide<img id=\"arrow\" src=\"/images/up_arrow.gif\">');
		e.preventDefault();
	 });
	
	
	$('#cart_toggle').live('click', function(e) {  /*for shopping cart and search box toggling */
		$(this).next('div').toggle('drop');
		e.preventDefault();
	 });
	
	$('.cart_add').click(function () {
		$('#sidebar:hidden').show('drop');
	});
	
	$('#hide_cart').click(function () {
		$('#sidebar').hide('drop');
		return false;
	})
	
	$('#lightbox').hide();

	$('.eval_link a').live('click', function(e) {
		var url = $(this).attr('href') + ' .lightbox_back';
		$('#lightbox').load(url).fadeIn(800);
		e.preventDefault();
	});
	
	$('.lightbox_close a').live('click', function(e) {
		$(this).closest('div.lightbox_back').fadeOut("slow");
		$('.lightbox').empty();
		e.preventDefault();
	});
	
	$('.calendar_body a img, .eval_link a img, .cart_add').tooltip({
		predelay:500,

		// use the fade effect instead of the default
		effect: 'fade',

		// make fadeOutSpeed similar to the browser's default
		fadeOutSpeed: 100,

		// tweak the position
		position: 'top center'
	});
	
});

