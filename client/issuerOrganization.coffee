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

Template.issuerOrganization.events
  'submit form': (e) ->
    organization =
      name: e.target.name.value
      url: e.target.url.value
      email: e.target.email.value
      description: e.target.description.value
      image: ""
    Meteor.call 'createOrganization', organization, share.alertProblem
    Router.go('admin')
    return false