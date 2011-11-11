class @Home     
  constructor: (element) -> 
    @home = element;
    subnav = @home.closest(".subnav");
    home_id = subnav.parent().find(".working_pair").attr("id").split("_")[2];
    home_metatag = subnav.find(".metatag_"+home_id)
    gauge = @home.closest(".subnav .gauge");
    metatags = subnav.find(".metatag")
    index = metatags.index(home_metatag);
    percentage = index/(metatags.size()-1);
    @home.css("top", 24 + percentage * (gauge.height()-87) );
  
$(document).ready -> 
  $('.vertical_navigation .up').live 'click', (event) ->
    if( ! $(this).hasClass("disabled") )
      $(this).closest(".subnav").find(".metatags").scrollTo({ top: '-=82px', left: '+=0px' }, 800);
  $('.vertical_navigation .down').live 'click', (event) ->
    if( ! $(this).hasClass("disabled") )
      $(this).closest(".subnav").find(".metatags").scrollTo({ top: '+=82px', left: '+=0px' }, 800);
  $('.vertical_navigation .home').live 'click', (event) ->
    subnav = $(this).closest(".subnav")
    home_class = $(this).attr("data-target")
    metatags  = subnav.find(".metatags")
    home = metatags.find(home_class)
    index = metatags.find(".metatag").index(home);
    location = home.height() * (index-1);
    metatags.scrollTo({ top: location, left: '+=0px' }, 800);
    
  $('.metatags').scroll ->
    subnav = $(this).closest(".subnav");
    metatags = subnav.find(".metatags"); 
    fromTop = metatags.scrollTop()

    count = subnav.find(".metatag").size();
    gauge = subnav.find(".gauge")
    position = subnav.find(".position")
    
    h = subnav.find(".metatag").first().height()
    percentage = 0.5
    if( count <= 3 ) 
      percentage = 0.5
    else
      percentage = (fromTop+h)/((count-1)*h);
    
    position.css("top", 12 + percentage * (gauge.height()-87) );
    
    up = subnav.find(".up")
    down = subnav.find(".down")
    up.removeClass("disabled")
    down.removeClass("disabled")
    if( fromTop < h ) 
      up.addClass("disabled");
    if( fromTop >= ( h * (count-3)) )
      down.addClass("disabled");
    
  $('.subnav .metatags').scrollTop("0px");
