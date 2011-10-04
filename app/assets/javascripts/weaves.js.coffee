# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready -> 
  make_images_zoomable();
  $('#home_button').topLink {  min: 400 * 5, fadeSpeed: 500 };
  
  $('#home_button').click ->
    $('html, body').animate({scrollTop:0}, 'slow');
 
  #$("#home_button").click ->
  #  $('html, body').animate({scrollTop:0}, 'slow');
  $(".delete_weave")
    .bind "ajax:success", (event, data) ->
      $(this).closest(".container").fadeOut();
      

