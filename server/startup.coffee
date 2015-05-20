add_default = ->
  if Meteor.users.find().count() > 0
    return
  users = [
    { username:"admin", email: "badger@gamestartschool.org", password: "kicktothegroin", roles:['admin', 'issuer']},
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
  add_default()




