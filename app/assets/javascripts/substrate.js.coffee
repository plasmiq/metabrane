$(document).ready -> 
  $(".substrate_container img").live "click", (event) ->
    img = $(this);
    tab = img.parent().find(".substrate_tab");
    if( img.hasClass("active") )
      img.removeClass("active") 
      tab.hide();
    else
      img.addClass("active") 
      tab.show();
