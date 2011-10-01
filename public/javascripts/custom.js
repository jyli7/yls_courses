$(document).ready(function() {
	
	$('.other_rows:even').addClass('zebra'); /*horizontal bars in the courses table */
	
	$('.descrip_body').hide();
	
	$('.course_name_click').click(function() {
		$(this).closest('div').next().slideToggle('slow');
		return false;
	 });

	$('.eval_link a').live('click', function(e) {
		var url = $(this).attr('href');
		$('#lightbox').hide().load(url).fadeIn("slow");
		e.preventDefault();
	});
	
	$('.lightbox_close a').live('click', function(e) {
		$(this).closest('div.lightbox_back').fadeOut("slow");
		$('.lightbox').empty();
		e.preventDefault();
	});
	
});

