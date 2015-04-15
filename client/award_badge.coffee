Template.award_badge.events
  'click .btn-grant-badge': (event, template) ->
    user = Blaze.getData(event.target)
    badge = template.data.badge
    if(badgeAssertions.find({uid: badge._id, "recipient.identity": user.identity }).count())
      Meteor.call 'revokeBadge', user._id, badge._id, share.alertProblem
    else
      Meteor.call 'grantBadge', user._id, badge._id, share.alertProblem

  'keyup input.username-search': (evt) ->
    Session.set("usernameSearch", evt.currentTarget.value);


Template.award_badge.helpers
  users: ->
    keyword  = Session.get("usernameSearch");
    query = new RegExp( keyword, 'i' );
    console.log keyword
    return Meteor.users.find { $or: [ {'username': query}, {'password': query} ] }

    #return Meteor.users.find({"username": {$regex : Session.get('usernameSearch')}}, {sort: {username:1}})

  badge: ->
    return Router.current().data().badge

  hasBadge: ->
    badgeAssertions.find(
      uid: Router.current().data().badge._id
      "recipient.identity": this.identity
    ).count() != 0