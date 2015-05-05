Template.badge_builder.helpers
  badge: -> return Router.current().data().badge or {}

Template.badge_builder.events
  'click .removeBadge': ->
    if window.confirm "Perminantly Remove "+this.name + "?"
      console.log "Removing "+this
      Meteor.call "removeBadge", this._id
      Router.go('/admin')

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
    reader = new FileReader()
    reader.onload = (e) ->
      imageURI = e.target.result
      convertToSmallPngSrc(imageURI)
    reader.readAsDataURL(f)

  'click .cameraSubmit': (e) ->
    target = $(e.target)
    target.css('background-color', 'darkgrey')
    target.html('Submitting...')
    target.toggleClass( "cameraSubmit" )
    commitBadge($(e.target).attr('data-_id'))

Template.badge_builder.rendered = ->
  badge = Router.current().data().badge
  canvas = $("#badgeCanvas")[0]
  canvas.width = 300
  canvas.height = 300
  context = canvas.getContext("2d")
  image = new Image()
  image.onload = ->
    context.drawImage(image, 0, 0, canvas.width, canvas.height)
  image.src = badge.image


  window.onmessage = (e) ->
    if e.origin == 'https://www.openbadges.me'
      imageURI = JSON.parse(e.data).image
      convertToSmallPngSrc(imageURI)

commitBadge = (_id) ->
  canvas = $("#badgeCanvas")[0]
  imageFromCanvas = canvas.toDataURL("image/png")

  badgeData =
    image: imageFromCanvas
    origin:Meteor.absoluteUrl()
    name: $("#badgename").val()
    description: $("#badge-description").val()
    issuer: $("#selectedOrganization").val()
    layerData: "nope"
    email: "what@sdf.com"
    _id: _id or false

  if badgeData.name and badgeData.description and badgeData.issuer and badgeData.image
    Meteor.call "createBadge", badgeData, (error, reason) ->
      if error
        alert error
      else
        Router.go('/admin')
  else
    alert('Please choose an organization, enter a name, and provide a description.')

convertToSmallPngSrc = (imageURI) ->
  image = new Image()

  image.onload = ->
    canvas = document.getElementById("badgeCanvas")
    canvas.width = 300
    canvas.height = 300
    ctx = canvas.getContext("2d")
    exif = EXIF.getData(image, ->
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
    )
    ctx.drawImage(image, 0, 0, canvas.width, canvas.height)
  image.src = imageURI
