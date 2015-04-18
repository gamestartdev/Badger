Template.admin_users.helpers
  users: ->
    return  Meteor.users.find().fetch()

Template.edit_user.helpers
  isSelected: -> this._id == Session.get('selectedUserId')
  isAdmin: -> share.isAdmin(Meteor.user())
  isSuperAdmin: -> return Meteor.user() and Meteor.user().username == "admin"
  isInOrg: (user) ->
    return organizations.findOne {_id:this._id, users: user._id}
  myOrganizations: ->
    if share.isAdmin(Meteor.user())
      myOrgs = organizations.find()
    else
      myOrgs = organizations.find({users: Meteor.userId()})
    return myOrgs

Template.edit_user.events
  'click .userRow': (e,t) ->
    console.log t.data
    Session.set('selectedUserId', t.data._id)

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
