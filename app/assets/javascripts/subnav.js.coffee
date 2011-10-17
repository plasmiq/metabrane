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
    position = subnav.find(".position")
    distance = gauge.height() / count;
    current = (gauge.height()-85)*list.scrollTop()/list.height();
    position.animate( { top: (10+current)+"px" }, { duration: 0 });
  $('.subnav .metatags').scrollTop("0px");
