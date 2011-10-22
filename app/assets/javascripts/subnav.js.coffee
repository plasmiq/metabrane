class @Home 
  constructor: (element) -> 
    @home = element;
    subnav = @home.closest(".subnav");
    home_id = subnav.parent().find(".working_pair").attr("id").split("_")[2];
    home_metatag = subnav.find(".metatag_"+home_id)
    gauge = subnav.find(".gauge")
    count = subnav.find(".metatag").size();
    list = subnav.find(".metatags")
    distance = (gauge.height() - 40)/ count;
    in_order = subnav.find(".metatag").index(home_metatag);
    home_position = (in_order) * distance;
    @home.css("top", 22 + home_position );

  
$(document).ready -> 
  $('.vertical_navigation .up').live 'click', (event) ->
    $(this).closest(".subnav").find(".metatags").scrollTo({ top: '-=85px', left: '+=0px' }, 800);
  $('.vertical_navigation .down').live 'click', (event) ->
    $(this).closest(".subnav").find(".metatags").scrollTo({ top: '+=85px', left: '+=0px' }, 800);
    
  $('.metatags').scroll ->
    subnav = $(this).closest(".subnav");
    count = subnav.find(".metatag").size();
    gauge = subnav.find(".gauge")
    list = subnav.find(".metatags")
    up = subnav.find(".up, .disabled_up")
    down = subnav.find(".down, .disabled_down")
    position = subnav.find(".position")
    fromTop = list.scrollTop();
    h = subnav.find(".metatag").first().height()
    current = fromTop / ( (count-2) * h ) * (gauge.height()-25);
    position.animate( { top: (10+current)+"px" }, { duration: 0 });
  
    if( fromTop <= up.height() ) 
      up.removeClass("up");
      up.addClass("disabled_up");
    else if( fromTop >= ( subnav.find(".metatag").first().height()* (count-3)) )
      down.removeClass("down");
      down.addClass("disabled_down");
    else 
      up.addClass("up");
      up.removeClass("disabled_up")
      down.addClass("down");
      down.removeClass("disabled_down")
    
  $('.subnav .metatags').scrollTop("0px");
