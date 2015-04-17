Template.badge_builder.events

  'click .useBadgeBuilder': (e,t) ->
    openDesigner = ->
      URL = 'https://www.openbadges.me/designer.html?origin=' + Meteor.absoluteUrl()
      URL = URL+'&email=badges@gamestartschool.org'
      URL = URL+'&close=true&format=json'
      options = 'width=400,height=400,location=0,menubar=0,status=0,toolbar=0'
      designerWindow = window.open(URL,'',options)
    openDesigner()


  'change #cam': (e) ->
    f = e.target.files[0]
    reader = new FileReader();
    reader.onload = (e) ->
      imageData = e.target.result
      $( "#badge-image" ).attr "src", imageData
    reader.readAsDataURL(f)

  'click .cameraSubmit': (e) ->
    commitBadge()

Template.badge_builder.rendered = ->
  window.onmessage = (e) ->
    if e.origin == 'https://www.openbadges.me'
      badgeData = JSON.parse(e.data)
      $( "#badge-image" ).attr "src", badgeData.image

commitBadge = ->
  badgeData =
    image: convertToSmallPngSrc()
    origin:Meteor.absoluteUrl()
    name: $("#badgename").val()
    description: $("#badge-description").val()
    issuer: $("#badge_builder select").val()
    layerData: "nope"
    email: "what@sdf.com"
    issuer: "http://www.gamestartschool.org"

  if badgeData.name and badgeData.description and badgeData.issuer
    Meteor.call "createBadge", badgeData, (error, reason) ->
      if error
        alert error
      else
        Router.go('/')
  else
    alert('Please choose an organization, enter a name, and provide a description.')

convertToSmallPngSrc = ->
  image = new Image()
  image.src = $( "#badge-image" ).attr("src")
  canvas = convertImageToCanvas(image)
  image = convertCanvasToImage(canvas)
  return image.src

convertImageToCanvas = (image) ->
  canvas = document.getElementById("badgeCanvas")
  canvas.width = 300
  canvas.height = 300
  canvas.getContext("2d").drawImage(image, 0, 0, 300, 300)
  return canvas;

#  exif = EXIF.readAsDataURL(image)
#  console.log "IMAGE!!:"
#  console.log exif
#  if exif
#    switch exif.Orientation
#      when 8 then  ctx.rotate(90*Math.PI/180)
#      when 3 then ctx.rotate(180*Math.PI/180)
#      when 6 then ctx.rotate(-90*Math.PI/180)


convertCanvasToImage = (canvas) ->
  image = new Image()
  image.src = canvas.toDataURL("image/png")
  return image
