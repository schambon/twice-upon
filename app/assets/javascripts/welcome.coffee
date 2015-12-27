# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
update = () ->
  last = $.ajax {
    url: "/#{user}/#{counter}/update",
    type: "get",
    dataType: "json",
    success: (data) ->
      cooldown = data.cooldown
      if cooldown
        $("#btn").removeClass('shown').addClass('hidden')
        $("#cld").removeClass('hidden').addClass('shown')
      else
        $("#btn").removeClass('hidden').addClass('shown')
        $("#cld").removeClass('shown').addClass('hidden')
      $('#ago').text(data.ago)
      $('#events_count').text(data.events_count)
    error: (xhr, status, error) ->
      console.error(status, error)
  }

window.setInterval(update, 2000);
