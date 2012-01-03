$(document).ready -> 
  $(".container .substrate_container img").live "click", (event) ->
    if( ! $(this).hasClass("invalid_url") )
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
        
  $(".substrate_tab a").live 'click', (event) ->
    $(this).parent().parent().find("img.active").click();
  
  
    
  #$('.substrate_tab_edit').live 'click', (event) ->
    #side = (if $(this).closest(".object").hasClass("left") then "left" else "right");
    #oposite_side = (if side == "left" then "right" else "left");
    #direction = (if (side == "left") then 1 else -1);
    
    #container = $(this).closest(".container")
    
    #container.find(".content").animate( { left: direction * 380 }, { duration: 'slow' });
    #container.find(".substrate_delete."+side).show("slow");
    #container.find(".substrate_url."+side).show("slide",{direction: side }, 500);
    #container.find(".notification."+side).addClass("loaded");
    #container.find(".substrate_tab_zoom a").attr("value") 
    
  $(".substrate_delete").live "click", (event) ->
    side = (if $(this).hasClass("left") then "left" else "right");
    oposite_side = (if side == "left" then "right" else "left");
    
    container = $(this).closest(".container")
    object = container.find(".object."+side);
    
    
    img = object.find("img");
    img.attr("src", img.attr("data-default") ); 
    container.find(".content").animate( { left: 0 }, { duration: 'slow' });
    url = object.find(".substrate_tab_zoom").attr("data-real-url"); 
    container.find(".image_url."+side).text( url );
    #container.find(".substrate_container img."+side).attr("src","");
    container.find(".substrate_url."+side).hide("slide",{direction: side}, 500);
    container.find(".notification."+side).removeClass("loaded");
    $(this).hide();
    
  $(".image_url").live "keyup input change", (event) ->
    exp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/; 
    side = (if $(this).hasClass("left") then "left" else "right");
    oposite_side = (if side == "left" then "right" else "left");
    direction = (if (side == "left") then 1 else -1);
        
    container = $(this).closest(".container")
    object = container.find(".object."+side);
    img = object.find(".substrate_container img")
    notification = container.find(".notification."+side)
    
    if((this.value.match(exp))) 
      match = exp.exec(this.value);
      img.attr( "src", this.value);
      img.addClass("new")
      notification.removeClass("invalid");
      notification.addClass("loaded");
    else
      img.attr( "src", "");
      img.removeClass("new")
      notification.addClass("invalid");
      notification.removeClass("loaded");
