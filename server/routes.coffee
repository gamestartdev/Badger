formatUrl = (s) ->
  path = if typeof s is 'string' then s else s['_id']
  return Meteor.absoluteUrl path, {replaceLocalhost:true}


Router.route('/openbadges/:o/:id',
  ->
    contentType = 'application/json'
    data = switch @params.o
      when 'issuerOrganization'
        name: 'GameStart Default Issuer'
        url: 'http://www.gamestartschool.org'
      when 'badgeClass'
        badge = badgeClasses.findOne {_id: @params.id}
        name: badge.name
        description: badge.description
        criteria: formatUrl badge.criteria
        image: formatUrl badge.image
        issuer: formatUrl 'openbadges/issuerOrganization/' + badge.issuer
      when 'badgeAssertion'
        assertion = badgeAssertions.findOne {_id: @params.id}
        uid: assertion.uid
        issuedOn: assertion.issuedOn.toISOString()
        badge: formatUrl assertion.badge
        verify:
          type: 'hosted'
          url: formatUrl assertion.verify.url
        recipient:
          type: 'email'
          hashed: false
          identity: assertion.identity #BROKEN
      when 'image'
        contentType = 'image/png'
        image = images.findOne({_id: @params.id})
        new Buffer(image.data.substr(image.data.indexOf(",") + 1), 'base64')

    @response.writeHead(200, { 'Content-Type': contentType })
    @response.end(if data instanceof Buffer then data else JSON.stringify data)
  where: 'server',
)