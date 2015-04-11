Template.badgeActions.helpers(
  users: ->
    badge = Router.current().data().badge
    userData = _.map(Meteor.users.find().fetch(), (user) ->
      if(typeof user.emails != "undefined")
        return {
          address: user.emails[0].address
          identity: user.identity
          hasBadge: badgeAssertions.find({uid: badge._id,\
                      "recipient.identity": user.identity}).count() != 0
          _id: user._id
        }
      else
        return
    )
    return _.sortBy(userData, (user) ->
      return user.address
    )
  badge: ->
    return Router.current().data().badge
)

