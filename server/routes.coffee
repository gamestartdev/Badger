Router.route('/v1/data/badges/images/:imageid',
  ->
    image = images.findOne({_id: @params.imageid})
    data = new Buffer(image.data.substr(image.data.indexOf(",") + 1), 'base64')
    @response.writeHead(200, { 'Content-Type': 'image/png' })
    @response.end(data)
  where: 'server',
)

Router.route('/v1/data/badges/classes/:classid',
  ->
    data = JSON.stringify(badgeClasses.findOne({_id: @params.classid}))
    @response.writeHead(200, { 'Content-Type': 'application/json' })
    @response.end(data)
  where: 'server',
)

Router.route('/v1/data/badges/assertions/:assertionid',
  ->
    data = JSON.stringify(badgeAssertions.findOne({_id: @params.assertionid}))
    @response.writeHead(200, { 'Content-Type': 'application/json' })
    @response.end(data)
  where: 'server',
)
