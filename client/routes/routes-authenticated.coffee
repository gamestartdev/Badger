Router.route('create',
  path: '/create'
  template: 'create'
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'organizations'
  onBeforeAction: ->
    Session.set 'currentRoute', 'create'
    @next()
)

Router.route('organization',
  path: '/organization'
  template: 'organization'
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'organizations'
  onBeforeAction: ->
    Session.set 'currentRoute', 'organization'
    @next()
)

Router.route('viewBadges',
  path: '/view'
  template: 'viewBadges'
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'organizations'
    Meteor.subscribe 'organizationBadges'
    Meteor.subscribe 'userBadgeAssertions'
    Meteor.subscribe 'userBadges'
  onBeforeAction: ->
    Session.set 'currentRoute', 'viewBadges'
    @next()
)

Router.route('badges',
  path: '/badges'
  template: 'badges'
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'organizations'
    Meteor.subscribe 'organizationBadges'
    Meteor.subscribe 'userBadgeAssertions'
    Meteor.subscribe 'userBadges'
  onBeforeAction: ->
    Session.set 'currentRoute', 'badges'
    @next()
)

Router.route('badge',
  path: '/badges/:badgeId'
  template: 'badgeActions'
  data: ->
    Meteor.subscribe 'organizationBadges'
    return {
      badge: badgeClasses.findOne({_id: @params.badgeId})
    }
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'allUsers'
    Meteor.subscribe 'organizationBadges'
    Meteor.subscribe 'assertionKeys'
  onBeforeAction: ->
    Session.set 'currentRoute', 'badgeActions'
    @next()
)
