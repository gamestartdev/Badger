Template.badge_builder.events
  'click .useBadgeBuilder': (e,t) ->
    openDesigner = ->
      URL = 'https://www.openbadges.me/designer.html?origin=' + Meteor.absoluteUrl()
      URL = URL+'&email=badges@gamestartschool.org'
      URL = URL+'&close=true&format=json'
      options = 'width=400,height=400,location=0,menubar=0,status=0,toolbar=0'
      designerWindow = window.open(URL,'',options)
    openDesigner()

#  'click #cam': ->
#    return false

  'change #cam': (e) ->
    f = e.target.files[0]
    reader = new FileReader();
    reader.onload = (e) ->
      imageData = e.target.result
      $( "#badge-image" ).attr "src", imageData
    reader.readAsDataURL(f)

  'click .cameraSubmit': (e) ->
    convertToSmallPng()
    #commitBadge()

Template.badge_builder.rendered = ->
  window.onmessage = (e) ->
    if e.origin == 'https://www.openbadges.me' and e.data != 'cancelled'
      badgeData = JSON.parse(e.data)
      $( "#badge-image" ).attr "src", badgeData.image

commitBadge = ->

  #      image = new Image()
  #      image.src = imageData
  #      canvas = convertImageToCanvas(image)
  #      image = convertCanvasToImage(canvas)
  #      imageData = image.src

  badgeDataWithImage = {image: $( "#badge-image" ).attr("src"), origin:Meteor.absoluteUrl()}
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

convertToSmallPng = ->
  image = new Image()
  image.src = $( "#badge-image" ).attr("src")

  canvas = convertImageToCanvas(image)
  image = convertCanvasToImage(canvas)
  $( "#badge-image" ).attr("src", image.src)

convertImageToCanvas = (image) ->
  canvas = document.getElementById("badgeCanvas")
  canvas.width = image.width
  canvas.height = image.height
  canvas.getContext("2d").drawImage(image, 0, 0, 200, 200)
  return canvas;

convertCanvasToImage = (canvas) ->
  image = new Image()
  image.src = canvas.toDataURL("image/png")
  return image