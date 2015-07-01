Template.index.helpers
  badge_data: ->
    user = Meteor.user()
    if user
      badges = share.badgesForUser(user)
      data =
        badges: badges
        count: badges.count()
        badge_ref: '/viewBadge/' + this._id
        total_badge_count: badgeClasses.find().count()
      return data

Template.whatever.onRendered ->
  ageInput = $('#at-field-age')
  ageInput.change ->
    age = parseInt(ageInput.val())
    if age > 13
      $('#parentname-row').hide()
    else
      $('#parentname-row').show()