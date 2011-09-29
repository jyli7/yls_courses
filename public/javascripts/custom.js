$(document).ready(function() {
	
  $('.other_rows:even').addClass('zebra'); /*horizontal bars in the courses table */
  $('.descrip_body').hide();
  $('.course_name_click').click(function() {
	$(this).closest('div').next().slideToggle('slow');
	return false;
  });

});


$('td.course_number').click(function() {
	$(this).next().hide();  
});

