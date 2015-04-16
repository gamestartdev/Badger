Template.badgeDesigner.helpers
  origin: ->
    return Meteor.absoluteUrl()

Template.badge_builder.helpers
  useBadgeBuilder: ->
    return Session.get('useBadgeBuilder')

Template.badge_builder.events
  'click .useBadgeBuilder': (e,t) ->
    e.preventDefault();
    Session.set('useBadgeBuilder', !Session.get('useBadgeBuilder'))

    openDesigner = ->
      URL = 'https://www.openbadges.me/designer.html?origin=' + Meteor.absoluteUrl()
      URL = URL+'&email=badges@gamestartschool.org'
      URL = URL+'&close=true&format=json'
      options = 'width=400,height=400,location=0,menubar=0,status=0,toolbar=0'
      designerWindow = window.open(URL,'',options)
    openDesigner()

  'change #cam': (e) ->
    e.preventDefault();
    f = e.target.files[0]
    reader = new FileReader();
    reader.onload = (e) ->
      imageData = e.target.result

      #      image = new Image()
      #      image.src = imageData
      #      canvas = convertImageToCanvas(image)
      #      image = convertCanvasToImage(canvas)
      #      imageData = image.src

      $( "#output" ).attr "src", imageData
    reader.readAsDataURL(f)

  'click .cameraSubmit': (e) ->
    e.preventDefault();
    commitBadge({image: $( "#output" ).attr("src"), origin:Meteor.absoluteUrl()})

Template.badge_builder.rendered = ->
  window.onmessage = (e) ->
    console.log "OnMessage"
    console.log e.data
    if(e.origin=='https://www.openbadges.me')
      if(e.data!='cancelled')
        imageData = e.data
        badgeData = JSON.parse(imageData)
        commitBadge(badgeData)

commitBadge = (badgeDataWithImage) ->
  name = $("#badgename").val()
  description = $("#badge-description").val()
  if name and description
    badgeDataWithImage.name = name
    badgeDataWithImage.issuer = $("#badge_builder select").val()
    badgeDataWithImage.description = description

    badgeDataWithImage.layerData = "nope"
    badgeDataWithImage.email = "what@sdf.com"
    badgeDataWithImage.issuer = "http://www.gamestartschool.org"

    console.log "BADGE"
    console.log badgeDataWithImage
    Meteor.call("createBadge", badgeDataWithImage, (error, reason) ->
      if error
        alert error
      else
        $("#badgedesigner").attr("src", $("#badgedesigner").attr("src"))
        $("#badgename").val('')
        $(".warning").css('visibility', 'hidden')
        Router.go('/')
    )
  else
    $("#badgename .warning").css('visibility', 'visible')

convertImageToCanvas = (image) ->
  canvas = document.createElement("canvas")
  canvas.width = image.width
  canvas.height = image.height
  canvas.getContext("2d").drawImage(image, 0, 0)
  return canvas;

convertCanvasToImage = (canvas) ->
  image = new Image()
  image.src = canvas.toDataURL("image/png")
  return image