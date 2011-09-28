$(document).ready(function() {
   $("a").click(function() {
     alert("Hello world!");
   });
 });

 $(document).ready(function() {
   $("#orderedlist").addClass("red");
 });

 $(document).ready(function() {
   $("#orderedlist > li").addClass("blue");
 });

 $(document).ready(function() {
   $("#orderedlist li:last").hover(function() {
     $(this).addClass("green");
   },function(){
     $(this).removeClass("green");
   });
 });

 $(document).ready(function() {
   // use this to reset a single form
   $("#reset").click(function() {
     $("form")[0].reset();
   });
 });

 $(document).ready(function() {
   $("li").not(":has(ul)").css("border", "1px solid black"); 
 });

$(document).ready(function() {
   $("a[name]").css("background", "#eee" );
 });

 $(document).ready(function() {
   $('#faq').find('dd').hide().end().find('dt').click(function() {
     $(this).next().slideToggle();
   });
 });

 $(document).ready(function(){
   $("a").hover(function(){
     $(this).parents("p").addClass("highlight");
   },function(){
     $(this).parents("p").removeClass("highlight");
   });
 });