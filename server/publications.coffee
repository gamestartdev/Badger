Meteor.publish 'allUsers', ->
  return Meteor.users.find()

Meteor.publish 'organizations', ->
  return organizations.find()

Meteor.publish 'badgeClasses', ->
  return badgeClasses.find()

Meteor.publish 'badgeAssertions', ->
  return badgeAssertions.find()