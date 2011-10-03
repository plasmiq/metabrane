# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready -> 
  $('a[rel*=facebox]').facebox()
  $(".delete_weave")
    .bind "ajax:success", (event, data) ->
      $(this).closest(".container").fadeOut()

  # 
  # If input field contain the URL, then load a image for preview
  #
  $("#new_image1").load -> 
    $("#hint1").fadeOut();
  $("#new_image2").load -> 
    $("#hint2").fadeOut();  
  $("#working_pair_relation").keyup ->
    if(this.value.length >= 3)
      $("#hint3").fadeOut();      
  
  $(".image_url").keyup ->
    exp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/; 
    img = $(this).attr("id").split("_")[2]
    if((this.value.match(exp))) 
      match = exp.exec(this.value);
      $("#new_"+img).attr( "src", this.value);
      $(this).closest(".substrate_url").removeClass("invalid");
    else
      $("#new_"+img).attr( "src", "");
      if(this.value.length > 2)
        $(this).closest(".substrate_url").addClass("invalid");      
