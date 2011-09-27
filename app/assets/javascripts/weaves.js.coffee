# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready -> 
  # 
  # If input field contain the URL, then load a image for preview
  #
  $(".image_url").keyup ->
    exp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/; 
    img = $(this).attr("id").split("_")[2]
    if((this.value.match(exp))) 
      match = exp.exec(this.value);
      $("#new_"+img).attr( "src", this.value);
      $("#"+img+"_info").text("");
    else
      if(this.value.length > 2)
        $("#"+img+"_info").text("Wrong URL");
      
