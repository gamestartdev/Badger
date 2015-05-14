hasBadge = (badge, user) ->
  badgeAssertions.find(
    uid: badge?._id
    userId: user?._id
  ).count() != 0

Template.view_badge.events
  'click .btn-grant-badge': (event, template) ->
    user = Blaze.getData(event.target)
    badge = template.data.badge
    assertion = badgeAssertions.findOne({uid: badge?._id, userId: user?._id })
    if assertion
      Meteor.call 'removeBadgeAssertion', assertion._id, share.alertProblem
    else
      Meteor.call 'createBadgeAssertion', user._id, badge._id, share.alertProblem

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
          Meteor.call 'createBadgeAssertion', user._id, badge._id, share.alertProblem


Template.view_badge.helpers
  badge: ->
    return Router.current().data().badge
  badge_organization: ->
    return issuerOrganizations.findOne({_id: this.issuer})
  users: ->
    usernameSearch = Session.get("usernameSearch")
    if not usernameSearch or usernameSearch.length <= 1
      return []
    query = new RegExp( Session.get("usernameSearch"), 'i' );
    return Meteor.users.find { $or: [ {'username': query}, {'password': query} ] }
  hasBadge: (badge) ->
    return hasBadge badge, this

  isIssuer: (badge) ->
      return issuerOrganizations.find ({_id:badge?.issuer, users: Meteor.userId()}).count() > 0
  badge_image: ->
    share.openBadgesUrl 'image', this.image

Template.push_badge.onRendered ->
  $('head').append('<script src="https://backpack.openbadges.org/issuer.js"></script>')

Template.push_badge.helpers
  hasBadge: ->
      return hasBadge Router.current().data().badge, Meteor.user()

Template.push_badge.events
  'click .pushToBackpack': (e, t) ->
    assertion = badgeAssertions.findOne
      userId: Meteor.userId()
      uid: t.data.badge?._id

    assertionUrl = share.openBadgesUrl 'badgeAssertion', assertion?._id
    console.log assertionUrl
    OpenBadges.issue assertionUrl, (errors, successes) ->
      console.log errors
      console.log successes
