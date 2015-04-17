Template.badge_grid.helpers
  badge_ref: ->
    return '/view_badge/' + this._id

  total_badge_count: ->
    return badgeClasses.find().count()

  badge_data: ->
    user = Meteor.user()
    if user
      badges = share.badgesForUserAndOrgs(user)
      return {badges: badges, count: badges.count()}