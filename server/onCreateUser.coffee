Accounts.onCreateUser (options, user) ->
#  user.isIssuer = true
  user.profile = options.profile if options.profile?
  user.username = share.determineEmail(user)
  return user
