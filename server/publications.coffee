Meteor.publish 'userData', ->
  currentUser = this.userId
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
      }
    })
  else
    this.ready()

Meteor.publish 'allUsers', ->
  return Meteor.users.find()

Meteor.publish 'organizations', ->
  return organizations.find()

Meteor.publish 'badgeClasses', ->
  return badgeClasses.find()

Meteor.publish 'badgeAssertions', ->
  return badgeAssertions.find()