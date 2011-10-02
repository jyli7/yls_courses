$(document).ready(function() {
	
	$('.other_rows:even').addClass('zebra'); /*horizontal bars in the courses table */
	
	$('.descrip_body').hide();
	
	$('.course_name_click').click(function() {
		$(this).closest('div').next().slideToggle('slow');
		return false;
	 });

	$('#lightbox').hide();

	$('.eval_link a').live('click', function(e) {
		var url = $(this).attr('href');
		$('#lightbox').load(url).fadeIn(800);
		e.preventDefault();
	});
	
	$('.lightbox_close a').live('click', function(e) {
		$(this).closest('div.lightbox_back').fadeOut("slow");
		$('.lightbox').empty();
		e.preventDefault();
	});
	
	$('.calendar_body a img, .eval_link a img').tooltip({
		predelay:750,

		// use the fade effect instead of the default
		effect: 'fade',

		// make fadeOutSpeed similar to the browser's default
		fadeOutSpeed: 100,

		// tweak the position
		position: "top center",
		offset:[-3]
	});
	
});

