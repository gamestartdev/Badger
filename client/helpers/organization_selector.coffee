Template.organization_selector.helpers(
  userOrganizations: ->
    organizations.find({})
)

Template.organization_selector.events(
  'change select': (e,t) ->
    Session.set('selectedOrganization', \
                $("#selectedOrganization").val())
)
