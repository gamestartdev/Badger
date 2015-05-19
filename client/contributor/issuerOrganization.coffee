Template.issuerOrganization.rendered = ->
  $(".organization-form").validate
    rules:
      organizationName:
        required: true
      organizationURL:
        required: true
      organizationEmailAddress:
        required: true
        email: true
      organizationDescription:
        required: false
      organizationImage:
        required: false
    messages:
      organizationEmailAddress:
        required: "Please enter an email"
        email: "The email address you have entered is invalid"
      organizationName:
        required: "Please enter a name for your orignization"
      organizationURL:
        required: "Full URL including 'http://'"

Template.issuerOrganization.helpers
  isAdmin: -> Meteor.user().isAdmin

Template.issuerOrganization.events
  'submit .organization-form': (e) ->
    organization =
      _id: e.target._id.value
      name: e.target.name.value
      url: e.target.url.value
      email: e.target.email.value
      description: e.target.description.value
      image: ""
    Meteor.call 'createOrganization', organization, share.alertProblem
    Router.go('admin')
    return false

  'click .deleteOrg': ->
    if window.confirm "Perminantly Remove "+this.name + "?"
      console.log "Removing "+this
      Meteor.call "removeOrganization", this._id
      Router.go('admin')
