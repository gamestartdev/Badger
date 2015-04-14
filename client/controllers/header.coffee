###
  Controller: Header
  Template: /client/includes/_header.html
###

# Events
Template.header.events
  'click .logout': (e,t) ->
    Meteor.logout (error)->
      alert error.reason if error

Template.header.helpers
  isAdmin: ->
    console.log Roles.userIsInRole(Meteor.user(), ['admin'])
    return Meteor.user() and Roles.userIsInRole(Meteor.user(), ['admin'])