Template.badgeDetails.events(
  'click .btn-grant-badge': (event, template) ->
    user = Blaze.getData(event.target)
    badge = template.data.badge
    if(badgeAssertions.find({uid: badge._id, "recipient.identity": user.identity }).count())
      $(event.target).text('Grant')
      Meteor.call 'revokeBadge', user._id, badge._id, (error, response) ->
        if error
          alert(error.reason)
        else
          if response.error
            alert(response.error)
    else
      $(event.target).text('Revoke')
      Meteor.call 'grantBadge', user._id, badge._id, (error, response) ->
        if error
          alert(error.reason)
        else
          if response.error
            alert(response.error)
)

Template.badgeDetails.helpers(
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

