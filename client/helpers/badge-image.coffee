Template.badgeImage.imageData = () ->
  console.log(Router.current.params)
  image = images.findOne({_id: @imageid})
  return image.data
