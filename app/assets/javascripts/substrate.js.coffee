$(document).ready -> 
  $(".substrate_container img").live "click", (event) ->
    img = $(this);
    tab = img.parent().find(".substrate_tab");
    container = $(this).closest(".container");
    container.find(".timeline .active").parent().click();
    if( img.hasClass("active") )
      img.removeClass("active") 
      tab.hide();
    else
      img.addClass("active") 
      tab.show();
