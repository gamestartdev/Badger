# Function: Accounts.onCreateUser()
# Hook into Meteor's account creation event to fire off a "welcome email"
# to new user's.
Accounts.onCreateUser((options,user)->
  # Pass our user over to our determineEmail function to see if we can
  # find an address to send our "welcome email" to. We also call up the profile
  # object to see if it exists and pull in a name if it's available.
  userData =
    email: share.determineEmail(user)
    name: if options.profile then options.profile.name else ""


  # Note: because this function overrides how Meteor inserts a new user into
  # the database, we need to ensure that the default implementation still works.
  # Here, we look for any options passed with the email/password and set them
  # as the profile, just like Meteor would if we *didn't* use this function.
  if options.profile
    user.profile = options.profile

  salt = CryptoJS.enc.Hex.stringify(CryptoJS.lib.WordArray.random(16))
  id = "sha256$" +
      CryptoJS.enc.Hex.stringify(CryptoJS.SHA256(userData.email + salt))
  identityObjectID = identityObjects.insert({
    identity: id,
    type: "email",
    hashed: true,
    salt: salt
  })
  user.identity = id

  return user
)