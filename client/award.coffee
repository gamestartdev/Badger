Template.award.helpers
  badge_data: ->
    user = Meteor.user()
    if user
      badges = share.badgesForOrgs(user)
      data =
        badges: badges
        count: badges.count()
        badge_ref: '/view_badge/' + this._id
        total_badge_count: badgeClasses.find().count()
      return data