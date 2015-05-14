formatUrl = (s) ->
  return Meteor.absoluteUrl s, {replaceLocalhost:true}

Router.route('/openbadges/issuer/:issuerid',
  ->
    data =
      name: 'GameStart Default Issuer'
      url: 'http://www.gamestartschool.org'
    @response.writeHead(200, { 'Content-Type': 'application/json' })
    @response.end(JSON.stringify data)
  where: 'server',
)

Router.route('/openbadges/image/:imageid',
  ->
    image = images.findOne({_id: @params.imageid})
    data = new Buffer(image.data.substr(image.data.indexOf(",") + 1), 'base64')
    @response.writeHead(200, { 'Content-Type': 'image/png' })
    @response.end(data)
  where: 'server',
)

Router.route('/openbadges/class/:classid',
  ->
    data = badgeClasses.findOne {_id: @params.classid}
    delete data._id


    data.criteria = formatUrl data.criteria
    data.image = formatUrl data.image
    data.issuer = formatUrl 'openbadges/issuer/gamestart'

    @response.writeHead(200, { 'Content-Type': 'application/json' })
    @response.end(JSON.stringify data)
  where: 'server',
)

Router.route('/openbadges/assertion/:assertionid',
  ->
    data = badgeAssertions.findOne {_id: @params.assertionid}
    delete data._id
    delete data.recipient._id
    delete data.recipient.salt
    delete data.evidence

    data.badge = formatUrl data.badge
    data.verify.url = formatUrl data.verify.url
    data.recipient.identity = 'thedenrei@gmail.com'
    data.recipient.hashed = false

    d = new Date()
    data.issuedOn = '2015-05-14T02:15:02.187Z' #d.toISOString()

    @response.writeHead(200, { 'Content-Type': 'application/json' })
    @response.end(JSON.stringify(data))
  where: 'server',
)