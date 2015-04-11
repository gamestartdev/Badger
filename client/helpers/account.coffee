Template.joinOrganization.helpers(
  organizations: ->
    user = Meteor.user()
    return _.map(organizations.find({}, {name: 1, url: 1}).fetch(), (org) ->
      org.hasUser = _.contains(org.users, user._id)
      return org
    )
)

Template.myBadges.helpers(
  badges: ->
    user = Meteor.user()
    assertions = badgeAssertions.find(
      {"recipient.identity": user.identity}).fetch()
    ids = _.pluck(assertions, 'uid')
    return badgeClasses.find({_id: { $in: ids}})
    return badges
)
