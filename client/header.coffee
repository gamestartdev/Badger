###
  Controller: Header
  Template: /client/includes/_header.html
###

# Events
Template.header.events
  'click .logout': (e,t) ->
    Meteor.logout (error)->
      alert error.reason if error
      Router.go "/"

Template.header.helpers

  currentRoute: (route) ->
    return if Session.equals("currentRoute", route) then "active"