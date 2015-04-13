###
  Publications
  Data being published to the client.
###

# /profile

Meteor.publish('userData', ->
  # Cache this.userId first since we use it twice below.
  currentUser = this.userId
  # If a current user is available, find the current user and publish the
  # specified fields. Note: Meteor stores OAuth emails differently than it does
  # for accounts created using the standard accounts-password package.
  if currentUser
    Meteor.users.find({_id: currentUser}, {
      fields: {
        "services.facebook.email": 1
        "services.github.email": 1
        "services.google.email": 1
        "services.twitter.screenName": 1
        "emails.address[0]": 1
        "profile": 1
        "identity": 1
        "admin": 1
      }
    })
  else
    this.ready()
)

Meteor.publish('organizations', ->
  return organizations.find({}, {fields: {name: 1, url: 1, users: 1}})
)

Meteor.publish('organizationBadges', ->
  userOrgs = organizations.find({ users: @userId }).fetch()
  urls = []
  if userOrgs.length > 0
    urls = _.map(userOrgs, (org) ->
      return org.url
    )
  else
    return []
  return badgeClasses.find({ issuer: { $in: urls }})
)

Meteor.publish('allUsers', ->
  return Meteor.users.find({}, {fields: {emails: 1, identity: 1, _id: 1}})
)

Meteor.publish('assertionKeys', ->
  return badgeAssertions.find({}, field: {uid: 1, "recpient.identity": 1})
)

Meteor.publish('userBadgeAssertions', ->
  user = Meteor.users.findOne({_id: @userId})
  return badgeAssertions.find({"recipient.identity": user.identity})
)
Meteor.publish('userBadges', ->
  user = Meteor.users.findOne({_id: @userId})
  assertions = badgeAssertions.find(
    {"recipient.identity": user.identity}).fetch()
  ids = _.pluck(assertions, 'uid')
  return badgeClasses.find({_id: { $in: ids}})
)
