# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready -> 
  bind_time_arrows()
  $('a[rel*=facebox]').facebox()
  $(".delete_weave")
    .bind "ajax:success", (event, data) ->
      $(this).closest(".container").fadeOut()

bind_time_arrows = () ->   
  $(".timearrow, .homebutton")
    .bind "ajax:before", (event,data) -> 
      id = this.id.split("_")[1]
      #$("#working_pair_"+id).fadeOut
    .bind "ajax:success", (event, data) ->
      id = this.id.split("_")[1]
      #$("#working_pair_"+id).replaceWith(data)
      $("#container_"+id).html(data)
      bind_time_arrows()
