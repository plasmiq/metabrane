$(document).ready ->

  $(".substrate_container img").error ->
    side = (if $(this).closest(".object").hasClass("left") then "left" else "right");
    $(this).addClass("invalid_url");
    $(this).attr("src","/assets/error_createWrongURL.png");
    
