Template.profile.helpers
  profileUser: ->
    return Router.current().data().profileUser

Template.profileContent.helpers
  badge_data: ->
    user = this
    console.log "BADGE DATA"
    console.log user
    if user
      badges = share.badgesForUser(user)
      data =
        badges: badges
        count: badges.count()
        total_badge_count: badgeClasses.find().count()
      return data
