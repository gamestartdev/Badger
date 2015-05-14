Meteor.publish 'allUsers', ->
  return Meteor.users.find()

Meteor.publish 'issuerOrganizations', ->
  return issuerOrganizations.find()

Meteor.publish 'badgeClasses', ->
  return badgeClasses.find()

Meteor.publish 'badgeAssertions', ->
  return badgeAssertions.find()