Template.join_organization.helpers
  hasUser: ->
    user = Meteor.user()
    if user
      _.contains(this.users, user._id)

  organizations: ->
    organizations.find({}, {name: 1, url: 1})

Template.join_organization.events
  'click .join': ->
    Meteor.call 'joinOrganization', Meteor.userId(), this._id, share.alertProblem

  'click .leave': ->
    Meteor.call 'leaveOrganization', Meteor.userId(), this._id, share.alertProblem

Template.create_organization.rendered = ->
  $("#create-organization").validate
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

