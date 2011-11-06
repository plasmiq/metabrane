# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready -> 
  make_images_zoomable();
  
  hide_relations = (event) ->
    event.stopImmediatePropagation();
    $(this).unbind('click');
    $(this).bind "click", show_relations
    $(this).removeClass("hide_relations");
    $(this).addClass("more_relations");
    weave = $(this).closest(".weave");
    weave.find(".subnav").slideUp("slow","linear");
    weave.animate( { height: weave.find(".working_pair").height()  }, {duration: "slow"} );
    $(this).bind "click", show_relations
    
  show_relations = (event) ->
    if( !$(this).hasClass("submit") ) 
      event.stopImmediatePropagation();
      $(this).unbind('click');
      $(this).bind "click", hide_relations;
      $(this).removeClass("more_relations");    
      $(this).addClass("hide_relations");
      weave = $(this).closest(".weave");
      weave.find(".subnav").slideDown("slow","linear");
      weave.animate( { height: "879px" }, {duration: "slow"} );
      weave.find(".metatags").scroll();
      new Home( weave.find(".home") )
  
  $(".timestamp span.info").live "click", (event) -> 
    link = $(this);
    toggles = link.parent().find(".toggles");
    if( link.hasClass("active") )
      link.removeClass("active") 
      toggles.hide();
    else
      link.addClass("active") 
      toggles.show();
      
  $(".timeline").live "hover", (event) ->     
    link = $(this);
    elements = link.find("a");
    if( link.find("a").hasClass("hover") )
      elements.removeClass("hover") 
    else
      elements.addClass("hover") 
    
      
  $(".timeline").live "click", (event) -> 
    link = $(this);
    elements = link.find("a,span");
    container = $(this).closest(".container")
    container.find(".substrate_container img.active").click();
    nav = container.find(".horizontal_navigation");
    if( link.find("a").hasClass("active") )
      elements.removeClass("active") 
      nav.hide();
    else
      elements.addClass("active") 
      nav.show();
  
  $('#home_button').topLink {  min: 400 * 5, fadeSpeed: 500 };
  $('#home_button').click ->
    $('html, body').animate({scrollTop:0}, 'slow');

  $(".more_relations").live "click", show_relations

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
      #$("body").addClass("busy");
      #$("body").attr("data-trigged-by", "#working_pair_"+id)

  
  #$("body.busy").live "click", (event) ->
  #  src = $("body").attr("data-trigged-by")
  #  weave = $(src)
  #  relation = weave.find(".relation")
  #  relation.click (e) ->
  #    if (!e) 
  #      e = window.event;
	#    e.cancelBubble = true;
	#    if (e.stopPropagation) 
	#      e.stopPropagation();
  #  edit_button = weave.find(".edit_relation");
  #  edit_button.fadeIn();
  #  edit_button.addClass("hide_relations")
  #  field = weave.find(".relation span input")
  #  field.prop("disabled",true)
  #  field.removeClass("active")
  #  submit = weave.find(".relation .button")
  #  submit.removeClass("submit")
  #  
  #  $("body").attr("data-trigged-by","")
  #  $(this).removeClass("busy")
  
  if $(".container").size() > 0
    
    $('.substrate_tab_edit').live 'click', (event) ->
      side = (if $(this).closest(".object").hasClass("left") then "left" else "right");
      oposite_side = (if side == "left" then "right" else "left");
      direction = (if (side == "left") then 1 else -1);
      
      container = $(this).closest(".container")
      
      container.find(".content").animate( { left: direction * 380 }, { duration: 'slow' });
      container.find(".substrate_delete."+side).show("slow");
      container.find(".substrate_url."+side).show("slide",{direction: side }, 500);
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
      container.find(".substrate_url."+side).hide("slide",{direction: side}, 500);
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
