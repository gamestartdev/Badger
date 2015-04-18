Template.header.helpers
  currentRoute: (route) ->
    return if Session.equals("currentRoute", route) then "active"
  header_text: ->
    if Session.equals("currentRoute", "profile")
      username = Router.current().data().username
      username + "'s Badges"
    else
      if Meteor.user()
        Meteor.user().username + "'s Badges"
      else
        "Welcome to GameStart Festival 2015!"

  isAdmin: -> share.isAdmin(Meteor.user())

Template.header.events
  'click .logout': (e,t) ->
    Meteor.logout (error)->
      alert error.reason if error
      Router.go "/"
