# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready -> 
  make_images_zoomable();
  $('#home_button').topLink {  min: 400 * 5, fadeSpeed: 500 };
  
  $('#home_button').click ->
    $('html, body').animate({scrollTop:0}, 'slow');

  $(".delete_weave")
    .bind "ajax:success", (event, data) ->
      $(this).closest(".container").fadeOut();
  
 
  $('.edit_relation').live "click", (event) ->
      $(this).fadeOut();
      id = $(this).closest(".working_pair").attr("id").split("_")[2]
      text_field = $("#working_pair_"+id+" .relation span input")
      text_field.prop("disabled",false)
      text_field.addClass("active")
      text_field.focus()
      submit = $("#working_pair_"+id+" .relation .button")
      submit.addClass("submit")
