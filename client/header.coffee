Template.header.helpers
  currentRoute: (route) ->
    return if Session.equals("currentRoute", route) then "active"
  header_text: ->
    if Meteor.user() then (Meteor.user().username + "'s Badges") else "Welcome to GameStart Festival 2015!"
  hasOrganization: ->
    user = Meteor.user()
    if user
      organizations.findOne({users: user._id})

Template.header.events
  'click .logout': (e,t) ->
    Meteor.logout (error)->
      alert error.reason if error
      Router.go "/"