Template.badgeImage.imageData = () ->
  image = images.findOne({_id: @imageid})
  return image.data
