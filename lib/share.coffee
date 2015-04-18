share.isAdmin = (user) ->
  return Roles.userIsInRole(user, ['admin'])

share.badgesForOrgs = (user) ->
  orgUrls = _.pluck(organizations.find({users: user._id}).fetch(), 'url')
  return badgeClasses.find {issuer: { $in: orgUrls}}

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