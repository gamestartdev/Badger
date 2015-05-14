
Router.route('/openbadges/:o/:id',
  ->
    contentType = 'application/json'
    data = switch @params.o
      when 'issuerOrganization'
        org = issuerOrganizations.findOne {_id: @params.id}
        name: org.name
        url: org.url
      when 'badgeClass'
        badge = badgeClasses.findOne {_id: @params.id}
        name: badge.name
        description: badge.description
        criteria: badge.criteria
        image: share.openBadgesUrl 'image', badge.image
        issuer: share.openBadgesUrl 'issuerOrganization', badge.issuer
      when 'badgeAssertion'
        assertion = badgeAssertions.findOne {_id: @params.id}
        uid: assertion._id
        issuedOn: assertion.issuedOn.toISOString()
        badge: share.openBadgesUrl 'badgeClass', assertion.badgeId
        verify:
          type: 'hosted'
          url: share.openBadgesUrl 'badgeAssertion', assertion._id
        recipient:
          type: 'email'
          hashed: false
          identity: share.determineEmail Meteor.users.find(assertion.userId)
      when 'image'
        contentType = 'image/png'
        image = images.findOne({_id: @params.id})
        new Buffer(image.data.substr(image.data.indexOf(",") + 1), 'base64')

    @response.writeHead(200, { 'Content-Type': contentType })
    @response.end(if data instanceof Buffer then data else JSON.stringify data)
  where: 'server',
)

hashStuff_notusedyet = ->
  salt = CryptoJS.enc.Hex.stringify(CryptoJS.lib.WordArray.random(16))
  id = "sha256$" +
    CryptoJS.enc.Hex.stringify(CryptoJS.SHA256(userData.email + salt))
  identityObjectID = identityObjects.insert({
    identity: id,
    type: "email",
    hashed: true,
    salt: salt
  })
