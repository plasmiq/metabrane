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
