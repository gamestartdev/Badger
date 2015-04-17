Template.user_admin.helpers
  users: -> Meteor.users.find()
  userIsSelected: ->
    if Session.get('adminSelection')
      return Session.get('adminSelection').username == this.username
  isInOrganization: ->
    if Session.get('adminSelection')
      return Session.get('adminSelection')._id in this.users

  allOrganizations: -> organizations.find()

Template.user_admin.events
  'click .userRow': (e,t) ->
    Session.set('adminSelection', this)
  'click .join': (e,t) ->
    Meteor.call "joinOrganization", Session.get('adminSelection')._id, this._id
  'click .leave': (e,t) ->
    Meteor.call "leaveOrganization", Session.get('adminSelection')._id, this._id

Template.org_admin.helpers
  organizations: -> organizations.find()

Template.org_admin.events
  'click .delete': ->
    console.log "Removing "+this
    Meteor.call "removeOrganization", this._id
