$(document).ready(function() {
	
  $('#course_list tr:even').addClass('zebra'); /*horizontal bars in the courses table */
  $('tr.course_descrip').hide();
  $('.course_name_click').click(function() {
	$(this).closest('tr').next().slideToggle('slow');
	return false;
  });

 
});


$('td.course_number').click(function() {
	$(this).next().hide();  
});




