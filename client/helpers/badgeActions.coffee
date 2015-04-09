Template.badgeActions.helpers(
  users: ->
    return _.map(Meteor.users.find().fetch(), (user) ->
      if(typeof user.emails != "undefined")
        return user.emails[0]
      else
        return
    )
  badge: ->
    return Router.current().data()
)
