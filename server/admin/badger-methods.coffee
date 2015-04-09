Meteor.methods(
  createBadge: (badgeData) ->
    check(badgeData, {name: String, email: String, image: String, \
                      origin: String, layerData: Match.Any, \
                      issuer: String})
    imageID = images.findAndModify({
      query: { data: badgeData.image },
      update: { $setOnInsert: { data: badgeData.image } },
      new: true,
      upsert: true,
    })
    bid = badgeClasses.insert({
      name: badgeData.name,
      image: "/badges/images/" + imageID._id,#TODO
      criteria: "/", #TODO
      issuer: badgeData.issuer, #TODO
      alignment: [],
      tags: [],
    })
    return true
  createOrganization: (org) ->
    check(org, {name: String, url: String, email: String, \
                      description: String, image: Match.Any})

    if(organizations.findOne({url: org.url}))
      throw new Meteor.Error(
        "organization-exists", "An organization already exists with that URL")

    oid = organizations.insert({
      name: org.name
      url: org.url
      email: org.email
      description: org.description
      image: org.image
    })

  joinOrganization: (user, org) ->
    check(org, {name: String, url: String, \
                users: Match.Optional(Array), _id: String})
    check(user, {_id: String, emails: Array, services: Object})
    organizations.update({_id: org._id}, {
      $addToSet: { users: user._id }
    })

  leaveOrganization: (user, org) ->
    check(org, {name: String, url: String, \
                users: Match.Optional(Array), _id: String})
    check(user, {_id: String, emails: Array, services: Object})
    organizations.update({_id: org._id}, {
      $pull: { users: user._id }
    })
)
