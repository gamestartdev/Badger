Meteor.methods(
  createBadge: (badgeData) ->
    check(badgeData, {name: String, email: String, image: String, \
                      origin: String, layerData: Match.Any})
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
      issuser: "/", #TODO
      alignment: [],
      tags: [],
    })
  createOrginization: (org) ->
    check(org, {name: String, url: String, email: String, \
                      description: String, image: Match.Any})

    if(orginizations.findOne({url: org.url}))
      throw new Meteor.Error(
        "orginization-exists", "An orginization already exists with that URL")

    oid = orginizations.insert({
      name: org.name
      url: org.url
      email: org.email
      description: org.description
      image: org.image
    })

  joinOrginization: (user, org) ->
    check(org, {name: String, url: String, users: Array, _id: String})
    check(user, {_id: String, emails: Array, services: Object})
    orginizations.update({_id: org._id}, {
      $addToSet: { users: user._id }
    })

  leaveOrginization: (user, org) ->
    check(org, {name: String, url: String, users: Array, _id: String})
    check(user, {_id: String, emails: Array, services: Object})
    orginizations.update({_id: org._id}, {
      $pull: { users: user._id }
    })
)
