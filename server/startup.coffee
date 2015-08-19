add_default = ->
  if Meteor.users.find().count() > 0
    return
  users = [
    { username:"aa", email: "badger@gamestartschool.org", password: "aa", roles:['admin', 'issuer']},
  ]
  for user in users
    checkUser = Meteor.users.findOne({"emails.address": user.email});
    if not checkUser
      userId = Accounts.createUser
        email: user.email
        password: user.password
        username: user.username
      Meteor.users.update userId, {$set: {isAdmin: 'admin' in user.roles, isIssuer: 'issuer' in user.roles}}


Meteor.startup ->
  console.log "Main Server Startup"
  add_default()
