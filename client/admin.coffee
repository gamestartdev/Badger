Template.org_admin.helpers
  allOrganizations: -> issuerOrganizations.find()
  myOrganizations: -> issuerOrganizations.find({users: Meteor.userId()})
  badgesForOrg: ->
    return badgeClasses.find { issuer:  this._id}
  badge_image: -> share.openBadgesUrl 'image', this.image
  isAdmin: -> Meteor.user().isAdmin

Template.org_admin.events
  'click .deleteOrg': ->
    if window.confirm "Perminantly Remove "+this.name + "?"
      console.log "Removing "+this
      Meteor.call "removeOrganization", this._id

  'click .createBadgeClass': ->
    Router.go 'create', {}, {query: {issuer: this._id} }

  'click .editBadge': ->
    Router.go 'create', {badgeId: this._id}

Template.admin.helpers
  isIssuer: ->
    share.isIssuer(Meteor.user())
