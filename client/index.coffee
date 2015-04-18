Template.index.helpers
  badge_data: ->
    user = Meteor.user()
    if user
      badges = share.badgesForUser(user)
      data =
        badges: badges
        count: badges.count()
        badge_ref: '/view_badge/' + this._id
        total_badge_count: badgeClasses.find().count()
      return data

Template.profile.helpers
  badge_data: ->
    username = Router.current().data().username
    user = Meteor.users.findOne({username: username })
    if user
      badges = share.badgesForUser(user)
      data =
        badges: badges
        count: badges.count()
        badge_ref: '/view_badge/' + this._id
        total_badge_count: badgeClasses.find().count()
      return data
  profileUser: ->
    username = Router.current().data().username
    user = Meteor.users.find({username: username})
