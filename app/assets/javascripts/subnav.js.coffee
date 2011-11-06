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
  $('.vertical_navigation .home').live 'click', (event) ->
    subnav = $(this).closest(".subnav")
    home_class = $(this).attr("data-target")
    metatags  = subnav.find(".metatags")
    home = metatags.find(home_class)
    index = metatags.find(".metatag").index(home);
    location = 85 * (index+1);
    metatags.scrollTo({ top: location+"px", left: '+=0px' }, 800);
    
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
      up.addClass("disabled");
    else if( fromTop >= ( subnav.find(".metatag").first().height()* (count-3)) )
      down.addClass("disabled");
    else 
      up.removeClass("disabled")
      down.removeClass("disabled")
    
  $('.subnav .metatags').scrollTop("0px");
