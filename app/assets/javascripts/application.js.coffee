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
    $('#drop .instruction').show()
    $('#drop .instruction input[type=file]').val(null)

    $('#preview form').hide()
    $('#preview form input[name=raw_data]').val(null)

    $('#preview img').attr('src', bg_image).addClass('eiwakun')

  cancel = (e) ->
    if(e.preventDefault)
      e.preventDefault()
    false

  readAndPreviewImage = (file) ->
    (reader = new FileReader()).onload = ->
      result = reader.result
      $('#preview form').show()
      $('#preview form input[name=raw_data]').val(result)
      $('#preview img').attr('src', result).removeClass('eiwakun')

    reader.readAsDataURL(file)

  dropped = (e) ->
    $('#drop').find('.instruction').hide()
    readAndPreviewImage e.dataTransfer.files[0]

  $('#drop').find('input[type=file]').change (e) ->
    $('#drop').find('.instruction').hide()
    readAndPreviewImage(e.target.files[0])

  $('#drop').on 'hidden', previewInit

  $('#drop').bind 'dragover', cancel
  $('#drop').bind 'dragenter', cancel
  $('#drop').bind 'drop', dropped

  previewInit()

$ ->
  postPicture()
