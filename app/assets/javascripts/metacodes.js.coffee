###
$(document).ready -> 
 $(".substrate_tab_layer").live 'click', (event) ->
   side = (if $(this).closest(".object").hasClass("left") then "left" else "right");
   direction = (if (side == "left") then 1 else -1);
   container = $(this).closest(".container")
   container.find(".metacode").tooltip( {delay: 0, extraClass: "meta tooltip",showURL: false, showBody: " - ", fade: 250, track: true });
   container.find(".content").animate( { left: direction * 380 }, { duration: 'slow' });
   if( side == "left" )
     container.find(".substrate_metacodes."+side).animate( { left : 0 }, { duration: 'slow' });
   else
     container.find(".substrate_metacodes."+side).animate( { right : 0 }, { duration: 'slow' });
###
 
$(".metacode").live 'click', (event) ->
  side = (if $(this).closest(".substrate_metacodes").hasClass("left") then "left" else "right");
  $('.metacode.selected').removeClass("selected");
  $(this).addClass("selected");
  val = $('.metacode.selected').attr("alt");
  $(this).closest(".substrate_metacodes").find("form #metacode").attr("value",val);
  
 $(".metacodes .submit").live 'click', (event) ->
   side = (if $(this).closest(".substrate_metacodes").hasClass("left") then "left" else "right");
   direction = (if (side == "left") then -1 else 1);
    
   container = $(this).closest(".container")
   container.find(".content").animate( { left: direction * 0 }, { duration: 'slow' });
   if( side == "left" )
     container.find(".substrate_metacodes."+side).animate( { left: -380 }, { duration: 'slow' });  
   else
     container.find(".substrate_metacodes."+side).animate( { right:  -380 }, { duration: 'slow' });  
 
