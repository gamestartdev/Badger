Meteor.startup ->

  users = [
    { name: "Admin", email: "admin@admin.com", password: "asdfasdf", roles:['admin']},
    { name: "Nate", email: "asdf@asdf.com", password: "asdfasdf", roles:['nothing'] }
  ]
  Meteor.users.remove({})
  console.log Meteor.users.find().count()

  # Loop through array of user accounts.
  for user in users

    # Check if the user already exists in the DB.
    checkUser = Meteor.users.findOne({"emails.address": user.email});

    # If an existing user is not found, create the account.
    if not checkUser
      id = Accounts.createUser
        email: user.email
        password: user.password
        profile:
          name: user.name

      if user.roles.length > 0
        Roles.addUsersToRoles(id, user.roles);


