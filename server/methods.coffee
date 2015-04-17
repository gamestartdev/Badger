Meteor.methods(
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
    return true


  createOrganization: (org) ->
    check(org, {name: String, url: String, email: String, description: String, image: Match.Any})

    if(organizations.findOne({url: org.url}))
      throw new Meteor.Error(
        "organization-exists", "An organization already exists with that URL")

    oid = organizations.insert({
      name: org.name
      url: org.url
      email: org.email
      description: org.description
      image: org.image
      users: [ Meteor.userId() ]
    })
    return true

  toggleIssuerRole: (userId) ->
    check(userId, String)
    if Roles.userIsInRole(Meteor.user(), ['admin'])
      user = Meteor.users.findOne({_id: userId})
      user.isIssuer = !user.isIssuer
      Meteor.users.update(user._id, user)

  joinOrganization: (userId, orgId) ->
    check(userId, String)
    check(orgId, String)
    organizations.update {_id: orgId}, { $addToSet: { users: userId } }

  leaveOrganization: (userId, orgId) ->
    check(userId, String)
    check(orgId, String)
    organizations.update {_id: orgId}, { $pull: { users: userId } }

  removeOrganization: (orgId) ->
    check(orgId, String)
    if Roles.userIsInRole(Meteor.user(), ['admin'])
      console.log "Removing organization "+ orgId
      organizations.remove(orgId)

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
    toUser = Meteor.users.findOne({_id: uid},
                               {_id: 1, identity: 1})
    if(!badgeAssertions.remove({uid: bid,\
                                "recipient.identity": toUser.identity }))
      throw new Meteor.Error("assertion-does-not-exist",
                             "This user doesn't have this badge")
    return true

)
