Template.header.helpers
  header_text: ->
    if Meteor.user() and Meteor.user().username
      Meteor.user().username + "'s Badges"
    else
      "Welcome to GameStart Festival 2015!"

  isAdmin: -> share.isAdmin(Meteor.user())

Template.header.events
  'click .logout': (e,t) ->
    Meteor.logout (error)->
      alert error.reason if error
      Router.go "/"
