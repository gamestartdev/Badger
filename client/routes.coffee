Meteor.subscribe 'allUsers'
Meteor.subscribe 'issuerOrganizations'
Meteor.subscribe 'badgeClasses'
Meteor.subscribe 'badgeAssertions'

Router.configure
  notFoundTemplate: 'notFound'
  layoutTemplate: 'layout'

Router.route 'index',
  path: '/'
  template: 'index'
  onBeforeAction: ->
    # Code to run before route goes here.
    Session.set 'currentRoute', 'index'
    @next()

Router.route 'profile',
  path: '/profile/:username'
  template: 'profile'
  data: ->
    return {
      profileUser: Meteor.users.findOne {username: @params.username}
    }
  onBeforeAction: ->
    Session.set 'currentRoute', 'profile'
    @next()

Router.route 'create',
  path: '/create/:badgeId?'
  template: 'create'
  data: ->
    return badgeClasses.findOne({_id: @params.badgeId}) or @params.query
  onBeforeAction: ->
    Session.set 'currentRoute', 'create'
    @next()


Router.route 'leaderboard',
  path: '/leaderboard'
  template: 'leaderboard'
  layoutTemplate: 'layoutLeaderboard',
  onBeforeAction: ->
    Session.set 'currentRoute', 'leaderboard'
    @next()

Router.route 'view_badge',
  path: '/view_badge/:badgeId'
  template: 'view_badge'
  data: ->
    return {
      badge: badgeClasses.findOne({_id: @params.badgeId})
    }
  onBeforeAction: ->
    Session.set 'currentRoute', 'view_badge'
    Session.set 'usernameSearch', ''
    @next()

Router.route 'issuerOrganization',
  path: '/issuerOrganization/:id?'
  template: 'issuerOrganization'
  data: ->
    return issuerOrganizations.findOne {_id: @params.id}
  onBeforeAction: ->
    Session.set 'currentRoute', 'issuerOrganization'
    @next()

Router.route 'admin',
  path: '/admin'
  template: 'admin'
  onBeforeAction: ->
    Session.set 'currentRoute', 'admin'
    @next()

Router.route 'award',
  path: '/award'
  template: 'award'
  onBeforeAction: ->
    Session.set 'currentRoute', 'award'
    @next()

Router.route 'email_badge_list',
  path: '/email_badge_list'
  template: 'email_badge_list'
  onBeforeAction: ->
    Session.set 'currentRoute', 'email_badge_list'
    @next()

checkUserLoggedIn = ->
  if not Meteor.loggingIn() and not Meteor.user()
    Router.go '/'
  else
    @next()

Router.onBeforeAction checkUserLoggedIn, except: [
  'index',
  'leaderboard',
  'profile',
  'view_badge',
]

