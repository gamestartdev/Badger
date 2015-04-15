add_default_users = ->
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
      id = Accounts.createUser
        email: user.email
        password: user.password
        username: user.username
      Roles.addUsersToRoles(id, user.roles);

add_default_orgs = ->
  orgs = [
    name: 'GameStart'
    url: 'http://www.gamestartschool.org'
    email: 'info@gamestartschool.org'
    description: 'We teach programming through video games'
    image: ''
  ]
  for org in orgs
    organizations.insert org

Meteor.startup ->
  Meteor.users.remove({})
  organizations.remove({})
  add_default_users()
  add_default_orgs()



