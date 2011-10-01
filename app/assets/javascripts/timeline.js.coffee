# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready -> 
  bind_time_arrows()

bind_time_arrows = () ->   
  $(".timeline")
    .bind "ajax:before", (event,data) -> 
      id = this.id.split("_")[1]
      $("#working_pair_"+id).fadeOut
    .bind "ajax:success", (event, data) ->
      id = this.id.split("_")[1]
      $("#working_pair_"+id).replaceWith(data)
      bind_time_arrows()

#  $(".timearrow").click ->
#    id = this.id.split("_")[1]
#    alert(id)
#    $("#working_pair_"+id).html("dsasdsda")
    
