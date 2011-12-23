$(document).ready -> 
  $("#proxy").click ->
    $(this).fadeOut 400, ->
      mov = $("#movie")
      mov.fadeIn 400, ->
        $(this).scroll()
        $f(this).api("play")
      

      

