Template.badgeActions.events(
  'click .btn-grant-badge': (event, template) ->
    user = Blaze.getData(event.target)
    badge = template.data.badge
    if(badgeAssertions.find({uid: badge._id,\
                             "recipient.identity": user.identity }).count())
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
