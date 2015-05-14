Meteor.methods

  createBadgeClass: (badgeData) ->
    check(badgeData, {name: String, image: String, \
                      origin: Match.Any, issuer: String, description: String, _id: Match.Any,
                      tags: Array, criteria: String})

    console.log "Creating Badge " + badgeData['_id']
    console.log badgeData
    imageId = images.insert({data: badgeData.image})

    badge =
      name: badgeData.name,
      image: imageId,
      criteria: badgeData.criteria,
      issuer: badgeData.issuer,
      description: badgeData.description,
      alignment: [],
      tags: badgeData.tags,

    if badgeData._id
      badgeClasses.update badgeData._id, badge
    else
      badgeClasses.insert badge

  removeBadgeClass: (badgeId) ->
    check(badgeId, String)
    badgeAssertions.remove({uid: badgeId})
    badgeClasses.remove({_id: badgeId})

  createOrganization: (org) ->
    check(org, {name: String, url: String, email: String, description: String, image: Match.Any})
    if share.isAdmin(Meteor.user()) or Meteor.user().isIssuer
      oid = issuerOrganizations.insert
        name: org.name
        url: org.url
        email: org.email
        description: org.description
        image: org.image
        users: [ Meteor.userId() ]

  removeOrganization: (orgId) ->
    check(orgId, String)
    if share.isAdmin(Meteor.user())
      console.log Meteor.user().username + " is Removing organization "+ orgId
      org = issuerOrganizations.findOne({_id: orgId})
      for badge in badgeClasses.find({issuer: org._id})
        badgeAssertions.remove({uid: badge._id})
      badgeClasses.remove({issuer: org._id})
      issuerOrganizations.remove(org)

  toggleIssuerRole: (userId) ->
    check(userId, String)
    if share.isAdmin(Meteor.user())
      user = Meteor.users.findOne userId
      user.isIssuer = !user.isIssuer
      Meteor.users.update(user._id, user)

  toggleAdminRole: (userId) ->
    check(userId, String)
    if share.isAdmin(Meteor.user())
      console.log "ADMIN"
      if Roles.userIsInRole(userId, ['admin'])
        Roles.setUserRoles(userId, [])
      else
        Roles.addUsersToRoles(userId, ['admin'])

  joinOrganization: (userId, orgId) ->
    check(userId, String)
    check(orgId, String)
    if share.isAdmin(Meteor.user()) or (Meteor.userId() in issuerOrganizations.findOne(orgId).users)
      issuerOrganizations.update orgId, { $addToSet: { users: userId } }

  leaveOrganization: (userId, orgId) ->
    check(userId, String)
    check(orgId, String)
    if share.isAdmin(Meteor.user()) or (Meteor.userId() in issuerOrganizations.findOne(orgId).users)
      issuerOrganizations.update {_id: orgId}, { $pull: { users: userId } }

  createBadgeAssertion: (userId, badgeId) ->
    check(userId, String)
    check(badgeId, String)
    badgeAssertions.insert
      badgeId: badgeClasses.findOne (badgeId)?._id
      userId: Meteor.users.findOne(userId)?._id
      issuedOn: new Date()
      evidence: ""

  removeBadgeAssertion: (assertionId) ->
    check(assertionId, String)
    badgeAssertions.remove assertionId

  removeUser: (userId) ->
    check(userId, String)
    user = Meteor.users.findOne {_id: userId}
    if share.isAdmin(Meteor.user()) and user
      badgeAssertions.remove {userId: user._id}
      Meteor.users.remove user

  sendEmail: (userId, options) ->
    check options, Object
    console.log "Sending email.. " + options.to
    if Meteor.user().username == 'admin'
      process.env.MAIL_URL = 'smtp://postmaster@gamestartschool.org:3d9f99f2b243ccfb98f8abe35401788c@smtp.mailgun.org:587';
      this.unblock()
      Email.send options
      Meteor.users.update userId, {$set: {emailed:true}}
