Meteor.startup ->

  Meteor.users.remove({})
  users = [
    { username:"admin", email: "a@a.com", password: "a", roles:['admin']},
    { username:"nate", email: "i@a.com", password: "a", roles:['issuer'] },
    { username:"leo", email: "u@a.com", password: "a", roles:[] }
  ]

  # Loop through array of user accounts.
  for user in users

    # Check if the user already exists in the DB.
    checkUser = Meteor.users.findOne({"emails.address": user.email});

    # If an existing user is not found, create the account.
    if not checkUser
      id = Accounts.createUser
        email: user.email
        password: user.password
        username: user.username

      if user.roles.length > 0
        Roles.addUsersToRoles(id, user.roles);


