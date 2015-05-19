Template.org_admin.helpers
  allOrganizations: -> issuerOrganizations.find()
  myOrganizations: -> issuerOrganizations.find({users: Meteor.userId()})
  badgesForOrg: ->
    return badgeClasses.find { issuer:  this._id}
  badge_image: -> share.openBadgesUrl 'image', this.image

Template.org_admin.events
  'click .createBadgeClass': ->
    Router.go 'create', {}, {query: {issuer: this._id} }

  'click .editBadge': ->
    Router.go 'create', {badgeId: this._id}

Template.admin.helpers
  isIssuer: ->
    share.isIssuer(Meteor.user())
