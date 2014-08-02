# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Validation
  @checkProduct = (id) ->
    valid = true
    if id is ""
      $('#errors ul').append("<li>Bitte geben Sie eine Produkt-ID ein.</li>")
      valid = false
    id = parseFloat(id)
    
    if Math.floor(id) isnt id or !$.isNumeric(id)
      $('#errors ul').append("<li>Die Produkt-ID muss eine ganze Zahl sein.</li>")
      valid = false
    unless valid
      $('#product-input').addClass("has-error")
      $('#errors').addClass("alert alert-danger")
    return valid

  @checkStore = (id) ->
    valid = true
    if !id or id is ""
      $('#errors ul').append("<li>Sie müssen einen Markt auswählen</li>")
      valid = false
    unless valid
      $('#store-input').addClass("has-error")
      $('#errors').addClass("alert alert-danger")
    return valid

  @removeClasses = ->
    $('#errors').removeClass("alert alert-danger")
    $('#store-input').removeClass("has-error")
    $('#product-input').removeClass("has-error")
    $('#errors ul').html("")

$ ->
  lastStore = localStorage.getItem('lastStore')
  $("#city_id").val(lastStore)
  $('#city_id').change( ->
    curr = $(this).val()
    localStorage.setItem('lastStore',curr)
  )
  $('#submit').click (e) ->
    e.preventDefault()
    Validation.removeClasses()
    city_id = $('#city_id').val()
    product_id = $('#product_id').val()
    url = "http://www.mediamarkt.de/webapp/wcs/stores/servlet/MultiChannelCatalogEntryAlternativeStoreAjax?storeId=48353&langId=-3&catEntryId=#{product_id}&pickUpStoreId=#{city_id}"
    valid_product = Validation.checkProduct(product_id)
    valid_city = Validation.checkStore(city_id)

    window.location = url if valid_product && valid_city
