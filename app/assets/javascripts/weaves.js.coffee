# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready -> 
  make_images_zoomable();
  
  hide_relations = () ->
    $(this).unbind('click');
    $(this).bind "click", show_relations
    $(this).removeClass("hide_relations");
    $(this).addClass("more_relations");
    weave = $(this).closest(".weave");
    weave.find(".subnav").hide("slow");
    weave.animate( { height: weave.find(".working_pair").height() }, {duration: "slow"} );
    $(this).bind "click", show_relations
    
  show_relations = () ->
    $(this).unbind('click');
    $(this).bind "click", hide_relations;
    $(this).removeClass("more_relations");    
    $(this).addClass("hide_relations");
    weave = $(this).closest(".weave");
    weave.find(".subnav").show("slow");
    weave.animate( { height: "879px" }, {duration: "slow"} );
    weave.find(".metatags").scroll();
  
  $('#home_button').topLink {  min: 400 * 5, fadeSpeed: 500 };
  $('#home_button').click ->
    $('html, body').animate({scrollTop:0}, 'slow');

  $(".more_relations").bind "click", show_relations

  $(".delete_weave")
    .bind "ajax:success", (event, data) ->
      $(this).closest(".container").fadeOut();
  
  $('.edit_relation').live "click", (event) ->
      $(this).fadeOut();
      $(this).removeClass("hide_relations");
      id = $(this).closest(".working_pair").attr("id").split("_")[2]
      text_field = $("#working_pair_"+id+" .relation span input")
      text_field.prop("disabled",false)
      text_field.addClass("active")
      text_field.focus()
      submit = $("#working_pair_"+id+" .relation .button")
      submit.addClass("submit")

  if $(".container").size() > 0
    
    $('.substrate_tab_edit').live 'click', (event) ->
      side = (if $(this).closest(".object").hasClass("left") then "left" else "right");
      oposite_side = (if side == "left" then "right" else "left");
      direction = (if (side == "left") then 1 else -1);
      
      container = $(this).closest(".container")
      
      container.find(".content").animate( { left: direction * 380 }, { duration: 'slow' });
      container.find(".substrate_delete."+side).show("slow");
      container.find(".substrate_url."+side).show("slow");
      container.find(".notification."+side).addClass("loaded");
      container.find(".substrate_tab_zoom a").attr("value") 
      
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
      container.find(".substrate_url."+side).hide("slow");
      container.find(".notification."+side).removeClass("loaded");
      $(this).hide();
      
    $(".image_url").live "keyup", (event) ->
      exp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/; 
      side = (if $(this).hasClass("left") then "left" else "right");
      oposite_side = (if side == "left" then "right" else "left");
      direction = (if (side == "left") then 1 else -1);
      
      
      container = $(this).closest(".container")
      object = container.find(".object."+side);
      
      if((this.value.match(exp))) 
        match = exp.exec(this.value);
        object.find(".substrate_container img").attr( "src", this.value);
        container.find(".notification."+side).removeClass("invalid");
        container.find(".notification."+side).addClass("loaded");
        #container.find(".notification."+side).removeAttr('disabled');
      else
        object.find(".substrate_container img").attr( "src", "");
        container.find(".notification."+side).addClass("invalid");
        container.find(".notification."+side).removeClass("loaded");
        #container.find(".notification."+side).attr('disabled', "disabled");
