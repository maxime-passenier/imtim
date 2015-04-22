define [
  'jquery'
  'underscore'
  'helper/stateStyle'
], ($, _, stateStyle)->

  widthImg = undefined
  nRoot = undefined
  nSearch = undefined
  rootStyle = undefined

  fixPremises = ->
    ns = $.find('.property-list .property')
    _.each ns, (n)->
      n = $(n)
      data = getPremiseData n
      premiseCleanup n
      setupPremise n, data
    rootStyle.enable(rootStyle.states.initialized).apply()
    setTimeout ->
      rootStyle.enable(rootStyle.states.active).apply()
    , 0
#    setTimeout ->
#      rootStyle.enable(rootStyle.states.search).apply()
#    , 1000

  getPremiseData = (n)->
    nLink = n.find('a')
    nType = n.find('.prop-type')
    type = nType.text()
    nType.remove()
    nRooms = n.find('.prop-price')
    rooms = nRooms.text()
    nRooms.remove()
    nPrice = n.find('.property-top')
    price = $.trim(nPrice.text())
    nAdress = n.find('.property-hover')
    adress = $.trim(nAdress.text())
    obj =
      link : nLink.attr('href')
      type : type
      rooms : rooms
      price : price
      adress : adress

  premiseCleanup = (n)->
    n.find('a').remove()

  setupPremise = (n, data)->
    n.attr('data-link', data.link);
    n.click ->
      window.location.href = $(this).attr('data-link')
    widthImg = if !widthImg? then n.width() else widthImg
    n.height( widthImg )
    $('<div />').addClass('premise-info premise-type').text(data.type).appendTo( n );
    nDetails = $('<div />').addClass('premises-details').appendTo( n );
    $('<div />').addClass('premise-info premise-adress').text(data.adress).appendTo( nDetails );
    $('<div />').addClass('premise-info premise-price').text(data.price).appendTo( nDetails );
    $('<div />').addClass('premise-info premise-rooms').text(data.rooms).appendTo( nDetails );

  setupSearch = ->
    nSearch = $('<div />').addClass('premises-search').appendTo(nRoot)
    console.log nSearch[0]

  load = ->
    rootStyle = stateStyle.create {
      initialized: 'premises-state-initialized'
      active: 'premises-state-active'
      search: 'premises-state-search'
    }
    nRoot = $('#PropertyListRegion')
    rootStyle.registerNode nRoot[0]
    fixPremises()
    setupSearch()

  load: load
