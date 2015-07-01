Template.header.helpers
  header_text: ->
    if Meteor.user() and Meteor.user().username
      Meteor.user().username
    else
      "GameStart Badging Pilot v0.1.1"

Template.header.events
  'click .logout': (e,t) ->
    Meteor.logout (error)->
      alert error.reason if error
      Router.go "/"
