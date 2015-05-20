Template.pushBadge.onRendered ->
  $('head').append('<script src="https://backpack.openbadges.org/issuer.js"></script>')

Template.pushBadge.helpers
  userHasBadge: ->
    return share.userHasBadge Meteor.user(), Router.current().data().badge

Template.pushBadge.events
  'click .pushToBackpack': (e, t) ->
    assertion = badgeAssertions.findOne
      badgeId: t.data.badge?._id
      userId: Meteor.userId()

    assertionUrl = share.openBadgesUrl 'badgeAssertion', assertion?._id
    console.log assertionUrl
    OpenBadges.issue assertionUrl, (errors, successes) ->
      console.log errors
      console.log successes
