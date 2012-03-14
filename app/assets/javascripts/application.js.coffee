# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http://example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.

#= require jquery
#= require jquery_ujs
#= require_tree .
#= require bootstrap

postPicture = () ->
  $.event.props.push('dataTransfer')

  bg_image = $('#preview img').attr('src')

  previewInit = (e) ->
    $('#preview form input[name=raw_data]').val(null)
    $('#preview form input[type=submit]').val('Drop below').attr({disabled: true}).removeClass('btn btn-success')
    $('#preview img').attr('src', bg_image).addClass('eiwakun')

  cancel = (e) ->
    if(e.preventDefault)
      e.preventDefault()
    false

  dropped = (e) ->
    file = e.dataTransfer.files[0]

    (reader = new FileReader()).onload = ->
      result = reader.result
      $('#preview form input[name=raw_data]').val(result)
      $('#preview form input[type=submit]').val('Send this!').attr({disabled: false}).addClass('btn btn-success')
      $('#preview img').attr('src', result).removeClass('eiwakun')

    reader.readAsDataURL(file)

  $('#drop').on 'hidden', previewInit

  $('#drop').bind 'dragover', cancel
  $('#drop').bind 'dragenter', cancel
  $('#drop').bind 'drop', dropped

  previewInit()

$ ->
  postPicture()
