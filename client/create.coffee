Template.badge_builder.events

  'click .useBadgeBuilder': (e,t) ->
    openDesigner = ->
      URL = 'https://www.openbadges.me/designer.html?origin=' + Meteor.absoluteUrl()
      URL = URL+'&email=badges@gamestartschool.org'
      URL = URL+'&close=true&format=json'
      options = 'width=400,height=400,location=0,menubar=0,status=0,toolbar=0'
      designerWindow = window.open(URL,'',options)
    openDesigner()

  'click .useUpload': (e,t) ->
    document.getElementById("cam").click()

  'change #cam': (e) ->
    f = e.target.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      imageData = e.target.result
      convertToSmallPngSrc(imageData)
    reader.readAsDataURL(f)
    Session.set('creationDisabled', false)

  'click .cameraSubmit': (e) ->
    commitBadge()

Template.badge_builder.helpers
  creationDisabled: ->
    return Session.equals('creationDisabled', true)

Template.badge_builder.rendered = ->
  Session.set('creationDisabled', true)
  window.onmessage = (e) ->
    if e.origin == 'https://www.openbadges.me'
      badgeData = JSON.parse(e.data)
      $( "#badge-image" ).attr "src", badgeData.image
      Session.set('creationDisabled', false)

commitBadge = () ->
  canvas = $("#badgeCanvas")[0]
  console.log canvas
  badgeData =
    image: canvas.toDataURL("image/png")
    origin:Meteor.absoluteUrl()
    name: $("#badgename").val()
    description: $("#badge-description").val()
    issuer: $("#selectedOrganization").val()
    layerData: "nope"
    email: "what@sdf.com"

  if badgeData.name and badgeData.description and badgeData.issuer and badgeData.image
    Meteor.call "createBadge", badgeData, (error, reason) ->
      if error
        alert error
      else
        Router.go('/admin')
  else
    alert('Please choose an organization, enter a name, and provide a description.')

convertToSmallPngSrc = (newData) ->
  image = new Image()
  image.src = newData
  if not image.src
    return false
  convertImageToCanvas(image)

convertImageToCanvas = (image) ->
  canvas = document.getElementById("badgeCanvas")
  canvas.width = 300
  canvas.height = 300
  ctx = canvas.getContext("2d")

  exif = EXIF.getData(image, (img) ->
    imageData = this
    orientation = EXIF.getTag(imageData, "Orientation")
    switch orientation
      when 6
        ctx.rotate(90*Math.PI/180)
        ctx.translate(0,-canvas.height)
      when 3
        ctx.rotate(180*Math.PI/180)
        ctx.translate(-canvas.width,-canvas.height)
      when 8
        ctx.rotate(-90*Math.PI/180)
        ctx.translate(-canvas.width,0)

    ctx.drawImage(image, 0, 0, canvas.width, canvas.height)
  ) ## like this?
