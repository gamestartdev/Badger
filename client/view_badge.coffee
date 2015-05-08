

Template.view_badge.events
  'click .btn-grant-badge': (event, template) ->
    user = Blaze.getData(event.target)
    badge = template.data.badge
    if(badgeAssertions.find({uid: badge._id, "recipient.identity": user.identity }).count())
      Meteor.call 'revokeBadge', user._id, badge._id, share.alertProblem
    else
      Meteor.call 'grantBadge', user._id, badge._id, share.alertProblem

  'keyup input.username-search': (evt) ->
    Session.set("usernameSearch", evt.currentTarget.value);

  'click .submitManyUsers': (e, t) ->
    badge = t.data.badge
    emails = share.splitCommas($('.manyUsers').val())
    for email in emails
      if email
        user = Meteor.users.findOne {"emails.address": email}
        alert("Granting badge to " + email)
        console.log "Granting badge to " + email + " " + user
        if user
          Meteor.call 'grantBadge', user._id, badge._id, share.alertProblem

Template.view_badge.helpers
  badge: ->
    return Router.current().data().badge
  badge_organization: ->
    return organizations.findOne({url: this.issuer})
  users: ->
    usernameSearch = Session.get("usernameSearch")
    if not usernameSearch or usernameSearch.length <= 1
      return []
    query = new RegExp( Session.get("usernameSearch"), 'i' );
    return Meteor.users.find { $or: [ {'username': query}, {'password': query} ] }
  hasBadge: (badge) ->
    if badge
      badgeAssertions.find(
        uid: badge._id
        "recipient.identity": this.identity
      ).count() != 0

  isIssuer: (badge) ->
    user = Meteor.user()
    if badge and user
      orgUrls = _.pluck(organizations.find({users: user._id}).fetch(), 'url')
      return badgeClasses.find({ _id: badge._id, issuer: { $in: orgUrls }}).count() > 0
