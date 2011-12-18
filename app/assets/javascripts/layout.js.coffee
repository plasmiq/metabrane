$(document).ready -> 

  $("#search input").keyup ->
    if $(this).attr("value").length > 0  
      $("#search .clear").show() 
    else 
      $("#search .clear").hide() 
  $("#search .clear").click ->
    $("#search input").attr("value","")
    $(this).hide()
    
  $(".sorting").click (e)->
    if $(this).hasClass("selected")
      e.preventDefault();
