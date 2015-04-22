share.isAdmin = (user) ->
  return Roles.userIsInRole(user, ['admin'])

share.badgesForOrgs = (user) ->
  orgUrls = _.pluck(organizations.find({users: user._id}).fetch(), 'url')
  return badgeClasses.find {issuer: { $in: orgUrls}}

share.badgesForUser = (user) ->
  assertions = badgeAssertions.find({"recipient.identity": user.identity}).fetch()
  earned_badge_ids = _.pluck(assertions, 'uid')
  return badgeClasses.find {_id: { $in: earned_badge_ids} }

share.determineEmail = (user)->
  if user.emails
    emailAddress = user.emails[0].address
  else if user.services
    services = user.services
    emailAddress = switch
      when services.facebook then services.facebook.email
      when services.github then services.github.email
      when services.google then services.google.email
      when services.twitter then null
      else null
  else
    null


share.alertProblem = (error, response) ->
  if error
    alert(error.reason)
  else
    if response.error
      alert(response.error)