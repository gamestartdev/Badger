Template.header.helpers
  header_text: ->
    if Meteor.user() and Meteor.user().username
      Meteor.user().username + "'s Badges"
    else
      "GameStart Badging Alpha Demo v0.0.2"

  isAdmin: -> share.isAdmin(Meteor.user())

Template.header.events
  'click .logout': (e,t) ->
    Meteor.logout (error)->
      alert error.reason if error
      Router.go "/"
