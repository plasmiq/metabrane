$(document).ready ->
  # 
  # If input field contain the URL, then load a image for preview
  #
  $("#new_image1").load -> 
    $(".content").animate( { left: 380 }, { duration: 'slow' });
    $("#hint1").fadeOut();
    $(".substrate_url.right").hide('slow');
    $("#hint2").hide('slow');
    $("#notification_image1").addClass("loaded");
  $("#notification_image1").click ->
    if( $(this).hasClass("loaded") ) 
      $(".content").animate( { left: 0 }, { duration: 'slow' });
      $(".substrate_url.left").hide('slow');
      if( ! $("#notification_image2").hasClass("loaded") )
        $(".substrate_url.right").show('slow');
    
    
  $("#new_image2").load -> 
    $(".content").animate( { left: -380 }, { duration: 'slow' });
    $("#hint2").fadeOut();
    $(".substrate_url.left").hide('slow');
    $("#hint1").hide('slow');
    $("#notification_image2").addClass("loaded");
  $("#notification_image2").click ->
    if( $(this).hasClass("loaded") ) 
      $(".content").animate( { left: 0 }, { duration: 'slow' });
      $(".substrate_url.right").hide('slow');  
      if( ! $("#notification_image2").hasClass("loaded") )
        $(".substrate_url.left").show('slow');
 
    
  $("#working_pair_relation").keyup ->
    if(this.value.length >= 3)
      $("#hint3").fadeOut();      
  
  $(".image_url, #working_pair_relation").focus ->
    $(this).attr("value","");
  
  $(".image_url").keyup ->
    exp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/; 
    img = $(this).attr("id").split("_")[2]
    
    if((this.value.match(exp))) 
      match = exp.exec(this.value);
      $("#new_"+img).attr( "src", this.value);
      $("#notification_"+img).removeClass("invalid");
    else
      $("#new_"+img).attr( "src", "");
      $("#notification_"+img).addClass("invalid");
      $("#notification_"+img).removeClass("loaded"); 
