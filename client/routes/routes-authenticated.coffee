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

Router.route('account',
  path: '/account'
  template: 'account'
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'organizations'
  onBeforeAction: ->
    Session.set 'currentRoute', 'account'
    @next()
)

Router.route('badges',
  path: '/badges'
  template: 'badges'
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'organizations'
    Meteor.subscribe 'organizationBadges'
  onBeforeAction: ->
    Session.set 'currentRoute', 'grant'
    @next()
)

Router.route('badge',
  path: '/badges/:badgeId'
  template: 'badgeActions'
  data: ->
    console.log(@params.badgeId)
    Meteor.subscribe 'organizationBadges'
    return badgeClasses.find({_id: @params.badgeId})
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'allUsers'
    Meteor.subscribe 'organizationBadges'
  onBeforeAction: ->
    Session.set 'currentRoute', 'badgeActions'
    @next()
)
