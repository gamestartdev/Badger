Template.admin_users.helpers
  isSuperAdmin: -> return Meteor.user() and Meteor.user().username == "admin"
  users: ->
    return  Meteor.users.find().fetch()
  raffleWinner: ->
    return Session.get('raffleUser')

Template.admin_users.events(
  'click .runRaffle': (e,t) ->
    allUsers = Meteor.users.find({}).fetch()
    counter = 0
    id = Meteor.setInterval(->
      counter = counter + 1
      if(counter > 100)
        return
      user = allUsers[_.random(0, allUsers.length - 1)]
      Session.set('raffleUser', user.username)
      share.username = user.username
    , 2)
    setTimeout ->
      Meteor.clearInterval(id)
    , 200
)

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
  'click .sendEmail': ->

    dataContext =
      profileUser: Meteor.users.findOne {username: this.username}

    console.log "Context:"
    console.log dataContext

    html = Blaze.toHTMLWithData Template.emailProfile, dataContext
    options =
      from: "sender@domain.com"
      to: "receiver@domain.com"
      subject: "I want to share this with you !"
      html: html

    if not Meteor.users.findOne({username: this.username}).emailed
      console.log "Emailing: " + this.username
      console.log options
      #Meteor.users.update {username: this.username}, {emailed: true}
      Meteor.call 'sendEmail', options
    else
      console.log "Already emailed " + this.username