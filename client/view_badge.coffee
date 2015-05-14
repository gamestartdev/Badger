hasBadge = (badge, user) ->
  badgeAssertions.find(
    badgeId: badge?._id
    userId: user?._id
  ).count() != 0

Template.view_badge.events
  'keyup input.username-search': (evt) ->
    Session.set("usernameSearch", evt.currentTarget.value);

  'submit .toggleBadgeAssertion': (e, t) ->
    e.preventDefault()
    user = this
    badge = t.data.badge
    evidence = e.target.evidence.value
    assertion = badgeAssertions.findOne { userId: user?._id, badgeId: badge?._id }
    if assertion?
      Meteor.call 'removeBadgeAssertion', assertion._id, share.alertProblem
    else
      Meteor.call 'createBadgeAssertion', user._id, badge._id, evidence, share.alertProblem

  'submit .submitManyUsers': (e, t) ->
    badge = t.data.badge
    evidence = e.target.evidence.value
    emails = share.splitCommas($('.manyUsers').val())
    for email in emails
        user = Meteor.users.findOne {"emails.address": email}
        Meteor.call('createBadgeAssertion', user._id, badge._id, evidence, share.alertProblem) if user? and email?

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
    orgs = issuerOrganizations.find {_id: badge?.issuer, users: Meteor.userId()}
    return orgs.count() > 0
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
      badgeId: t.data.badge?._id
      userId: Meteor.userId()

    assertionUrl = share.openBadgesUrl 'badgeAssertion', assertion?._id
    console.log assertionUrl
    OpenBadges.issue assertionUrl, (errors, successes) ->
      console.log errors
      console.log successes
