Router.route('/badges/images/:imageid',
  ->
    image = images.findOne({_id: @params.imageid})
    @response.writeHead(200, { 'Content-Type': 'text/html' })
    @response.end('<img src="'+image.data+'"/>')
  where: 'server',
)
