Template.award.helpers
  allOrganizations: -> issuerOrganizations.find()
  myOrganizations: -> issuerOrganizations.find({users: Meteor.userId()})
  badgesForOrg: ->
    badges: badgeClasses.find { issuer:  this._id}

Template.award.events
  'click .awardBadge': ->
    Router.go('/view_badge/' + this._id)

