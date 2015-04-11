Template.organization_selector.helpers(
  userOrganizations: ->
    user = Meteor.user()
    organizations.find({users: user._id})
  selectedOrganization: ->
    return Serssion.get('selectedOrganization')
)
