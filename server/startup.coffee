add_default = ->
  if Meteor.users.find().count() > 0
    return
  users = [
    { username:"admin", email: "admin@a.com", password: "a", roles:['admin', 'issuer']},
    { username:"nate", email: "nate@a.com", password: "a", roles:[] },
    { username:"leo", email: "leo@a.com", password: "a", roles:[] },
    { username:"a", email: "a@a.com", password: "a", roles:[] },
    { username:"b", email: "b@a.com", password: "a", roles:[] },
    { username:"c", email: "c@a.com", password: "a", roles:[] },
    { username:"d", email: "d@a.com", password: "a", roles:[] },
    { username:"e", email: "e@a.com", password: "a", roles:[] },
    { username:"f", email: "f@a.com", password: "a", roles:[] },
    { username:"g", email: "g@a.com", password: "a", roles:[] },
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




