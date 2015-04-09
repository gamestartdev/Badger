Router.route('/badges/images/:imageid',
  ->
    image = images.findOne({_id: @params.imageid})
    data = new Buffer(image.data.substr(image.data.indexOf(",") + 1), 'base64')
    @response.writeHead(200, { 'Content-Type': 'image/png' })
    @response.end(data)
  where: 'server',
)
