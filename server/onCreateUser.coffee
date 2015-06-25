Accounts.onCreateUser (options, user) ->
#  user.isIssuer = true
  user.profile = options.profile if options.profile?
  email = share.determineEmail(user)
  user.username = email
  badgeAssertions.update {email: email}, {$set: { userId: user._id } }, { multi: true }
  return user
