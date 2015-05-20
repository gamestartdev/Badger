Template.admin.helpers
  isIssuer: ->
    share.isIssuer(Meteor.user())
  myOrganizations: ->
    if Meteor.user()?.isAdmin
      return issuerOrganizations.find()
    return issuerOrganizations.find({users: Meteor.userId()})

Template.admin_organization.helpers
  badgesForOrg: ->
    return badgeClasses.find { issuer:  this._id}
  usersForOrg: ->
    return Meteor.users.find { _id: {$in: this.users }}
  badge_image: -> share.openBadgesUrl 'image', this.image

Template.admin_organization.events
  'click .createBadgeClass': ->
    Router.go 'create', {}, {query: {issuer: this._id} }
  'click .editBadge': ->
    Router.go 'create', {badgeId: this._id}
  'click .removeUserFromOrganization': (e,t) ->
    if share.confirm "Remove {#this._id} from organization?"
      Meteor.call "removeUserFromOrganization", this._id, t.data._id, share.alertProblem


Template.addUserToOrganizationRow.helpers
  what: ->
    return "yup"
Template.addUserToOrganizationRow.events
  'submit .addUserToOrganizationRow': (e, t) ->
    e.preventDefault()
    user = this
    console.log user
