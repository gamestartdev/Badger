Template.admin_users.helpers
  isSuperAdmin: -> return Meteor.user() and Meteor.user().username == "admin"
  users: ->
    return  Meteor.users.find().fetch()
  isSelected: -> this._id == Session.get('selectedUserId')
  isAdmin: -> share.isAdmin(Meteor.user())
  isSuperAdmin: -> return Meteor.user() and Meteor.user().username == "admin"
  isInOrg: (user) ->
    return issuerOrganizations.findOne {_id:this._id, users: user._id}
  myOrganizations: ->
    if share.isAdmin(Meteor.user())
      myOrgs = issuerOrganizations.find()
    else
      myOrgs = issuerOrganizations.find({users: Meteor.userId()})
    return myOrgs

Template.admin_users.events
  'click .userRow': (e,t) ->
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