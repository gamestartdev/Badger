Template.badge_grid.helpers
  badge_ref: ->
    return '/view_badge/' + this._id

  badges: ->
    user = Meteor.user()
    if user
      orgUrls = _.pluck(organizations.find({users: user._id}).fetch(), 'url')

      assertions = badgeAssertions.find({"recipient.identity": user.identity}).fetch()

      earned_badge_ids = _.pluck(assertions, 'uid')

      return badgeClasses.find { $or: [ {_id: { $in: earned_badge_ids}}, {issuer: { $in: orgUrls}} ]}