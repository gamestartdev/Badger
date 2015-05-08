Template.award.helpers
  allOrganizations: -> organizations.find()
  myOrganizations: -> organizations.find({users: Meteor.userId()})
  badgesForOrg: ->
    badges: badgeClasses.find { issuer:  this.url}

Template.award.events
  'click .awardBadge': ->
    Router.go('/view_badge/' + this._id)

