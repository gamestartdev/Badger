Template.createOrginizationModal.rendered = ->
  $("#create-orginization").validate(
    rules:
      orginizationName:
        required: true
      orginizationURL:
        required: false
      orginizationEmailAddress:
        required: true
        email: true
      orginizationDescription:
        required: false
      orginizationImage:
        required: false
    messages:
      orginizationEmailAddress:
        required: "Please enter an email"
        email: "The email address you have entered is invalid"
      orginizationName:
        required: "Please enter a name for your orignization"
    submitHandler: ->
      orginization =
        name: $('[name="orginizationName"]').val()
        url: $('[name="orginizationURL"]').val()
        email: $('[name="orginizationEmailAddress"]').val()
        description: $('[name="orginizationDescription"]').val()
        image: ""
      $('.modal-backdrop').hide()
      Meteor.call 'createOrginization', orginization, (error, response)->
        if error
          alert(error.reason)
        else
          if response.error
            alert(response.error)
  )
Template.createOrginizationModal.events(
  'submit form': (e) ->
    e.preventDefault()

  'click .btn-cancel': ->
    $('.modal-backdrop').hide()
)


Template.joinOrginization.events(
  'click .btn-cancel': ->
    $('.modal-backdrop').hide()

  'click .btn-join': (e,t) ->
    orginization = Blaze.getData(event.target)
    console.log(orginization)
    user = Meteor.user()
    if _.contains(orginization.users, user._id)
      $(e.target).text('Leave')
      Meteor.call 'leaveOrginization', user, orginization, (error, response) ->
        if error
          alert(error.reason)
        else
          if response.error
            alert(response.error)
    else
      $(e.target).text('Join')
      Meteor.call 'joinOrginization', user, orginization, (error, response) ->
        if error
          alert(error.reason)
        else
          if response.error
            alert(response.error)
)
