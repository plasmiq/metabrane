$(document).ready ->

  if $(".new_weave").size() > 0
    $(".object").fadeTo(0,0);
    
      
    $("#new_image1,#new_image2").load ->
      side = (if $(this).hasClass("left") then "left" else "right");
      oposite_side = (if side == "left" then "right" else "left");
      direction = (if (side == "left") then 1 else -1);

      $(this).show();
      $(".object."+side).fadeTo("slow", 1);
      $(".content").animate( { left: direction * 380 }, { duration: 'slow' });
      $(".hint."+side).fadeOut();
      $(".hint."+oposite_side).hide('slow'); 
      $(".substrate_url."+oposite_side).hide('slow');
      $(".notification."+side).addClass("loaded");
      $(".substrate_delete."+side).show();
      
    $("#notification_image1, #notification_image2").click ->
      side = (if $(this).hasClass("left") then "left" else "right");
      oposite_side = (if side == "left" then "right" else "left");
      if( $(this).hasClass("loaded") ) 
        $(".content").animate( { left: 0 }, { duration: 'slow' });
        $(".substrate_url."+side).hide("slide",{direction: side}, 500);
        if( ! $(".notification."+oposite_side).hasClass("loaded") )
          $(".substrate_url."+oposite_side).show('slow');
    
      
    $(".substrate_delete").click ->
      side = (if $(this).hasClass("left") then "left" else "right");
      oposite_side = (if side == "left" then "right" else "left");
      $(".content").animate( { left: 0 }, { duration: 'slow' });
      $(".substrate_container img."+side).attr("src","");
      $(".substrate_url."+side).show("slide",{direction: side}, 500);
      $(".image_url."+side).attr("value","");
      $(".notification."+side).removeClass("loaded");
      if( ! $(".notification."+oposite_side).hasClass("loaded") )
          $(".substrate_url."+oposite_side).show('slow');
      $(this).hide();
      
    $(".working_pair_relation").keyup ->
      if(this.value.length >= 3)
        $("#hint3").fadeOut();
        $(".submit_weave").addClass("loaded");      
    
    $(".image_url, #working_pair_relation").focus ->
      if( ! $(this).hasClass("typein") ) 
        $(this).addClass("typein");
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
       
    $(".new_weave form").submit ->
      return $(".notification.loaded").size() == 3
