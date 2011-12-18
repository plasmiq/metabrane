# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready -> 

  $("#tagline").hover (->
    link = $(this).find("a")
    placeholder = link.attr("placeholder")
    link.attr("placeholder", link.text())
    link.text( placeholder )
  ), (->
    link = $(this).find("a")
    placeholder = link.attr("placeholder")
    link.attr("placeholder", link.text())
    link.text( placeholder )
  )
  $("#metatags_sorting").selectmenu( {
    style:'dropdown'
  });
  $("#metatags_sorting").change ->
    value = $(this).val();
    window.location = $(".metatags_sorting."+value).attr("href");
    return false;

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
      new Home( weave.find(".gauge .home") )
      weave.find(".vertical_navigation .home").click()
  
  $(".timestamp span.info").live "click", (event) -> 
    link = $(this);
    toggles = link.parent().find(".toggles");
    if( link.hasClass("active") )
      link.removeClass("active") 
      toggles.hide();
    else
      link.addClass("active") 
      toggles.show();
      
  $(".timeline, .new_home").live "hover", (event) ->     
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
  
  $('.container .working_pair_relation').live "focus", (event) ->
    button = $(this).parent().find('.edit_relation');
    if( ! button.hasClass("cancel") ) 
      #alert("test");
      $(this).blur();
  
  $('.container .edit_relation, .container .working_pair_relation').live "click", (event) ->
    button = $(this).parent().find('.edit_relation');
    id = button.closest(".working_pair").attr("id").split("_")[2]
    text_field = $("#working_pair_"+id+" .relation span input")
    submit = $("#working_pair_"+id+" .relation .button")
    if( ! button.hasClass("cancel") ) 
      button.addClass("cancel");
      button.removeClass("hide_relations");
      text_field.addClass("active");
      text_field.focus();
      submit.addClass("submit");
    else
      button.removeClass("cancel");
      button.addClass("hide_relations");
      text_field.removeClass("active");
      text_field.blur();
      submit.removeClass("submit");
