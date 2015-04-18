Template.admin_users.helpers
  users: ->
    users = Meteor.users.find().fetch()

    if share.isAdmin(Meteor.user())
      myOrgs = organizations.find().fetch()
    else
      myOrgs = organizations.find({users: Meteor.userId()}).fetch()

    for user in users
      user.userOrganizations = myOrgs
#      for org in user.userOrganizations
#        org.isInOrg = (user in organizations.users)
    return users

Template.edit_user.helpers
  isAdmin: -> share.isAdmin(Meteor.user())
  isSuperAdmin: -> return Meteor.user() and Meteor.user().username == "admin"
  isInOrg: (user) ->
    return organizations.findOne {_id:this._id, users: user._id}

Template.edit_user.events
  'click .removeUser': (e,t) ->
    Meteor.call "removeUser", this._id
  'click .join': (e,t) ->
    Meteor.call "joinOrganization", t.data._id, this._id
  'click .leave': (e,t) ->
    Meteor.call "leaveOrganization", t.data._id, this._id
  'click .toggleIssuerRole': ->
    Meteor.call "toggleIssuerRole", this._id
  'click .toggleAdminRole': ->
    Meteor.call "toggleAdminRole", this._id
