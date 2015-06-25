Accounts.onCreateUser (options, user) ->
  user.isIssuer = true
  user.profile = options.profile if options.profile?
#
#  console.log "Looking for existing badges..."
#  email = share.determineEmail(user)
#  for assertion in badgeAssertions.find({userId: { $exists: false }, dsfs})
#    console.log "Assertion has no userId: "

  return user
