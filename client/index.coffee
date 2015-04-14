
Template.index.helpers
  badges: ->
    user = Meteor.user()
    assertions = badgeAssertions.find(
      {"recipient.identity": user.identity}).fetch()
    ids = _.pluck(assertions, 'uid')
    return badgeClasses.find({_id: { $in: ids}})
    return badges
  nav: -> Session.get('nav')