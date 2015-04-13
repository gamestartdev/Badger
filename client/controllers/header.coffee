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
    console.log Meteor.user().admin
    return Meteor.user() and Meteor.user().admin