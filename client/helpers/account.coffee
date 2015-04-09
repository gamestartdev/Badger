Template.joinOrganization.helpers(
  organizations: ->
    return organizations.find({}, {name: 1, url: 1})
)
