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

