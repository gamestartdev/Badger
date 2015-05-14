Template.org_admin.helpers
  allOrganizations: -> issuerOrganizations.find()
  myOrganizations: -> issuerOrganizations.find({users: Meteor.userId()})
  badgesForOrg: ->
    return badgeClasses.find { issuer:  this.url}

Template.org_admin.events
  'click .deleteOrg': ->
    if window.confirm "Perminantly Remove "+this.name + "?"
      console.log "Removing "+this
      Meteor.call "removeOrganization", this._id

  'click .createBadge': ->
    Session.set('selectedOrganization', this.url)
    Router.go('/create/new')

  'click .editBadge': ->
    Session.set('selectedOrganization', this.issuer)
    Router.go('/create/' + this._id)

  'click .awardBadge': ->
    Router.go('/view_badge/' + this._id)

Template.admin.helpers
  isIssuer: ->
    user = Meteor.user()
    if user
      return Meteor.user().isIssuer
