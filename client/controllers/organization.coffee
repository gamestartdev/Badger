Template.create_organization.rendered = ->
  $("#create-organization").validate(
    rules:
      organizationName:
        required: true
      organizationURL:
        required: false
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
    submitHandler: ->
      organization =
        name: $('[name="organizationName"]').val()
        url: $('[name="organizationURL"]').val()
        email: $('[name="organizationEmailAddress"]').val()
        description: $('[name="organizationDescription"]').val()
        image: ""
      $('.modal-backdrop').hide()
      Meteor.call 'createOrganization', organization, alert_problem
  )
Template.create_organization.events
  'submit form': (e) ->
    e.preventDefault()

  'click .btn-cancel': ->
    $('.modal-backdrop').hide()

Template.join_organization.events
  'click .btn-cancel': ->
    $('.modal-backdrop').hide()

  'click .btn-join': (e,t) ->
    organization = Blaze.getData(event.target)
    user = Meteor.user()
    if _.contains(organization.users, user._id)
      $(e.target).text('Join')
      Meteor.call 'leaveOrganization', user._id, organization._id, alert_problem
    else
      $(e.target).text('Leave')
      Meteor.call 'joinOrganization', user._id, organization._id, alert_problem


alert_problem = (error, response) ->
  if error
    alert(error.reason)
  else
    if response.error
      alert(response.error)