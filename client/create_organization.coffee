Template.create_organization.rendered = ->
  $(".create-organization").validate
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

    submitHandler: ->
      $('#create-organization-modal').foundation('reveal', 'close')
      organization =
        name: $('[name="organizationName"]').val()
        url: $('[name="organizationURL"]').val()
        email: $('[name="organizationEmailAddress"]').val()
        description: $('[name="organizationDescription"]').val()
        image: ""
      Meteor.call 'createOrganization', organization, share.alertProblem

Template.create_organization.events
  'submit form': (e) ->
    e.preventDefault()

