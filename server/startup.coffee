

add_default = ->
  orgs = [
    name: 'GameStart'
    url: 'http://www.gamestartschool.org'
    email: 'info@gamestartschool.org'
    description: 'We teach programming through video games'
    image: ''
  ]
  orgIds = []
  for org in orgs
    orgIds.push(organizations.insert(org))

  users = [
    { username:"admin", email: "admin@a.com", password: "a", roles:['admin', 'issuer']},
    { username:"nate", email: "nate@a.com", password: "a", roles:['issuer'] },
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
      Roles.addUsersToRoles(userId, user.roles);
      if user.roles.length > 1
        for org in organizations.find().fetch()
          Meteor.call "joinOrganization", userId, org._id

Meteor.startup ->
  Meteor.users.remove({})
  organizations.remove({})
  add_default()



