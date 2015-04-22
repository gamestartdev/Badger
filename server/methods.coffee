Meteor.methods

  testMeth: (a,e,c)->
    check(a, Number)
    check(e, Number)
    check(c, Number)
    if Meteor.user().username == 'denrei'

      console.log "TESTT"
      console.log a
      console.log e
      console.log c

      return 1
    else
      return 'No way burrito!'

  createBadge: (badgeData) ->
    check(badgeData, {name: String, email: String, image: String, \
                      origin: Match.Any, layerData: Match.Any, \
                      issuer: String, description: String})
    console.log "Creating Badge"
    console.log badgeData

    imageID = images.insert({data: badgeData.image})

    bid = badgeClasses.insert({
      name: badgeData.name,
      image: "/v1/data/badges/images/" + imageID,
      criteria: "/",
      issuer: badgeData.issuer,
      description: badgeData.description,
      alignment: [],
      tags: [],
    })

  removeBadge: (badgeId) ->
    check(badgeId, String)
    badgeAssertions.remove({uid: badgeId})
    badgeClasses.remove({_id: badgeId})

  createOrganization: (org) ->
    check(org, {name: String, url: String, email: String, description: String, image: Match.Any})
    if share.isAdmin(Meteor.user()) or Meteor.user().isIssuer
      if(organizations.findOne({url: org.url}))
        throw new Meteor.Error("organization-exists", "An organization already exists with that URL")

      oid = organizations.insert({
        name: org.name
        url: org.url
        email: org.email
        description: org.description
        image: org.image
        users: [ Meteor.userId() ]
      })

  removeOrganization: (orgId) ->
    check(orgId, String)
    if share.isAdmin(Meteor.user())
      console.log Meteor.user().username + " is Removing organization "+ orgId
      org = organizations.findOne({_id: orgId})
      for badge in badgeClasses.find({issuer: org.url})
        badgeAssertions.remove({uid: badge._id})
      badgeClasses.remove({issuer: org.url})
      organizations.remove(org)


  toggleIssuerRole: (userId) ->
    check(userId, String)
    if share.isAdmin(Meteor.user())
      user = Meteor.users.findOne({_id: userId})
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
    if share.isAdmin(Meteor.user()) or (Meteor.userId() in organizations.findOne(orgId).users)
      organizations.update orgId, { $addToSet: { users: userId } }

  leaveOrganization: (userId, orgId) ->
    check(userId, String)
    check(orgId, String)
    if share.isAdmin(Meteor.user()) or (Meteor.userId() in organizations.findOne(orgId).users)
      organizations.update {_id: orgId}, { $pull: { users: userId } }

  grantBadge: (uid, bid) ->
    check(uid, String)
    check(bid, String)
    toUser = Meteor.users.findOne({_id: uid},
                               {_id: 1, identity: 1})
    if(badgeAssertions.findOne({uid: bid,\
                                "recipient.identity": toUser.identity }))
      throw new Meteor.Error("assertion-exists",
                             "This user has already earned that badge")

    badge = badgeClasses.findOne({_id: bid})
    identityObject = identityObjects.findOne({identity: toUser.identity},
                                             {_id: 0})
    time = new Date().getTime()
    assertionId = badgeAssertions.insert({
      uid: badge._id,
      recipient: identityObject,
      badge: "/v1/data/badges/classes/" + badge._id,
      issuedOn: time,
      evidence: "", #TODO
    })
    badgeAssertions.update({ _id: assertionId }, {
      $set: {
        verify: {
          type: "hosted",
          url: "/v1/data/badges/assertions/" + assertionId
        }
      }
    })

  revokeBadge: (uid, bid) ->
    check(uid, String)
    check(bid, String)
    toUser = Meteor.users.findOne({_id: uid}, {_id: 1, identity: 1})
    if(!badgeAssertions.remove({uid: bid,\
                                "recipient.identity": toUser.identity }))
      throw new Meteor.Error("assertion-does-not-exist",
                             "This user doesn't have this badge")

  removeUser: (userId) ->
    check(userId, String)
    userToRemove = Meteor.users.findOne {_id: userId}
    if share.isAdmin(Meteor.user()) and userToRemove
      badgeAssertions.remove {"recipient.identity": userToRemove.identity}
      Meteor.users.remove userToRemove

  sendEmail: (options) ->
    check options, Object
    this.unblock()
    Email.send options