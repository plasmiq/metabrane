$(document).ready -> 
  $('.vertical_navigation .up').live 'click', (event) ->
    $(this).closest(".subnav").find(".metatags").scrollTo({ top: '-=85px', left: '+=0px' }, 800);
  $('.vertical_navigation .down').live 'click', (event) ->
    $(this).closest(".subnav").find(".metatags").scrollTo({ top: '+=85px', left: '+=0px' }, 800);
  $('.metatags').scroll ->
    $(this).closest(".subnav").find(".metatag").size();
    $(this).closest(".subnav").find(".position").animate( { top: '20px' }, { duration: 'slow' });
