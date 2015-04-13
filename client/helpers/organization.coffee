Template.join_organization.helpers(
  organizations: ->
    user = Meteor.user()
    return _.map(organizations.find({}, {name: 1, url: 1}).fetch(), (org) ->
      org.hasUser = _.contains(org.users, user._id)
      return org
    )
)

