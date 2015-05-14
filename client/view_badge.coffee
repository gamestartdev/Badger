hasBadge = (badge, user) ->
  badgeAssertions.find(
    badgeId: badge?._id
    userId: user?._id
  ).count() != 0

Template.view_badge.events
  'submit .toggleBadgeAssertion': (event, template) ->
    event.preventDefault()

    badge = template.data.badge
    user = this
    evidence = event.target.evidence.value

    console.log badge
    console.log user
    console.log evidence

    assertion = badgeAssertions.findOne { badgeId: badge?._id, userId: user?._id }
    if assertion?
      Meteor.call 'removeBadgeAssertion', assertion._id, share.alertProblem
    else
      Meteor.call 'createBadgeAssertion', user._id, badge._id, evidence, share.alertProblem

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
          Meteor.call 'createBadgeAssertion', user._id, badge._id, evidence, share.alertProblem


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
