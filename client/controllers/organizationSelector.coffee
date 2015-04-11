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
    console.log("YEAH")
    console.log($("#selectedOrganization"))
    Session.set('selectedOrganization', \
                $("#selectedOrganization").val())
)
