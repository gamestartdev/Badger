Template.organization_selector.helpers(
  userOrganizations: ->
    user = Meteor.user()
    if user
      organizations.find({users: user._id})
  selectedOrganization: ->
    return Serssion.get('selectedOrganization')
)


Template.organization_selector.rendered = -> (
  if Session.get('selectedOrganization')
    $("#selectedOrganization").val(Session.get('selectedOrganization'))
  else
    Session.set('selectedOrganization', $("#selectedOrganization").val())
)
Template.organization_selector.events(
  'change select': (e,t) ->
    Session.set('selectedOrganization', \
                $("#selectedOrganization").val())
  'ready select': (e,t) ->
    Session.set('selectedOrganization', \
                $("#selectedOrganization").val())
)
