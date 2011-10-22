// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function make_images_zoomable() {
  $('a[rel*=fancybox]').fancybox( 
    { 
      'titlePosition' : 'outside',
      'transitionIn'	:	'fade', 
      'transitionOut'	:	'fade', 
      'scrolling'     : 'no',
      'padding'       : 3,
      'width'         : 'auto',
      'height'        : 'auto',
      'autoDimensions': true,
      'centerOnScroll': true,
      'onComplete' : function() { 
        $("#fancybox-wrap").unbind('mousewheel.fb');
        $(document).unbind('keydown.fb');
      }, 
      showNavArrows: false
    } 
  );
  $('.working_pair_relation').autoGrowInput( { maxWidth: 600, comfortZone: 20 } );
  $(".substrate_container img").error( function() {
    side = ( $(this).closest(".object").hasClass("left") ? "left" : "right");
    var container = $(this).closest(".container");
    container.find(".notification."+side).removeClass("loaded");
    container.find(".notification."+side).attr("disabled","disabled");
    $(this).addClass("invalid_url");
    $(this).attr("src","/assets/error_createWrongURL.png");
  });
  $(".substrate_container img").load( function() {
    side = ( $(this).closest(".object").hasClass("left") ? "left" : "right");
    var container = $(this).closest(".container");
    if( $(this).attr("src") != "/assets/error_createWrongURL.png") {
      container.find(".notification."+side).removeAttr("disabled");
    }
  });
  $('form.live_update').live( "ajax:before", function(event, data, status, xhr) {
    var container = $(this).closest(".working_pair");
    container.children().fadeOut("slow");
    container.find(".loader").show();
  });
  $('form.live_update').submit( function(event) {
      if( ! $(this).find("input[type=submit]").hasClass("submit")) {
      //alert($(this).find("input[type=submit]").attr("class") );
        event.preventDefault();        
        return false;
      }
  });
  $(".metacode").tooltip( {delay: 0, showURL: false, showBody: " - ", fade: 250, track: true });
}
