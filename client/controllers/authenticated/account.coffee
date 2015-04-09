Template.createOrganizationModal.rendered = ->
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
      Meteor.call 'createOrganization', organization, (error, response)->
        if error
          alert(error.reason)
        else
          if response.error
            alert(response.error)
  )
Template.createOrganizationModal.events(
  'submit form': (e) ->
    e.preventDefault()

  'click .btn-cancel': ->
    $('.modal-backdrop').hide()
)


Template.joinOrganization.events(
  'click .btn-cancel': ->
    $('.modal-backdrop').hide()

  'click .btn-join': (e,t) ->
    organization = Blaze.getData(event.target)
    user = Meteor.user()
    if _.contains(organization.users, user._id)
      $(e.target).text('Leave')
      Meteor.call 'leaveOrganization', user, organization, (error, response) ->
        if error
          alert(error.reason)
        else
          if response.error
            alert(response.error)
    else
      $(e.target).text('Join')
      Meteor.call 'joinOrganization', user, organization, (error, response) ->
        if error
          alert(error.reason)
        else
          if response.error
            alert(response.error)
)
