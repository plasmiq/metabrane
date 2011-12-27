$(document).ready -> 
  $("#proxy").click ->
    $(this).fadeOut 400, ->
      mov = $("#movie")
      mov.fadeIn 400, ->
        $(this).scroll()
        $f(this).api("play")
        

  $(".persona").keyup ->
    if $(this).attr("value").length > 0  
      $("#start_here").fadeOut("fast") 
      $(this).addClass("active")
    else 
      $("#start_here").fadeIn("fast") 
      $(this).removeClass("active")
