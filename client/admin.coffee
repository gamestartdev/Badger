selectedUser = ->
  return Session.get('adminSelection')

Template.user_admin.helpers
  users: -> Meteor.users.find()
  userIsSelected: ->
    if selectedUser()
      return selectedUser().username == this.username
  isInOrganization: ->
    if selectedUser()
      return selectedUser()._id in this.users
  allOrganizations: -> organizations.find()


Template.user_admin.events
  'click .userRow': (e,t) ->
    Session.set('adminSelection', this)
  'click .join': (e,t) ->
    Meteor.call "joinOrganization", selectedUser()._id, this._id
  'click .leave': (e,t) ->
    Meteor.call "leaveOrganization", selectedUser()._id, this._id
  'click .toggleIssuerRole': ->
    Meteor.call "toggleIssuerRole", selectedUser()._id

Template.org_admin.helpers
  allOrganizations: -> organizations.find()
  myOrganizations: -> organizations.find({users: Meteor.userId()})
  badgesForOrg: ->
    return badgeClasses.find { issuer:  this.url}

Template.org_admin.events
  'click .deleteOrg': ->
    console.log "Removing "+this
    Meteor.call "removeOrganization", this._id

  'click .removeBadge': ->
    console.log "Removing "+this
    Meteor.call "removeBadge", this._id
