share.badgesForUserAndOrgs = (user) ->
  orgUrls = _.pluck(organizations.find({users: user._id}).fetch(), 'url')
  assertions = badgeAssertions.find({"recipient.identity": user.identity}).fetch()
  earned_badge_ids = _.pluck(assertions, 'uid')
  return badgeClasses.find { $or: [ {_id: { $in: earned_badge_ids}}, {issuer: { $in: orgUrls}} ]}

share.badgesForUser = (user) ->
  assertions = badgeAssertions.find({"recipient.identity": user.identity}).fetch()
  earned_badge_ids = _.pluck(assertions, 'uid')
  return badgeClasses.find {_id: { $in: earned_badge_ids} }

share.alertProblem = (error, response) ->
  if error
    alert(error.reason)
  else
    if response.error
      alert(response.error)