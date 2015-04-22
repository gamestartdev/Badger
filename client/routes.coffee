Meteor.subscribe 'allUsers'
Meteor.subscribe 'organizations'
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
    # Code to run before route goes here.
    Session.set 'currentRoute', 'profile'
    @next()

Router.route 'create',
  path: '/create'
  template: 'create'
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

Router.route 'admin',
  path: '/admin'
  template: 'admin'
  onBeforeAction: ->
    Session.set 'currentRoute', 'admin'
    @next()

checkUserLoggedIn = ->
  if not Meteor.loggingIn() and not Meteor.user()
    Router.go '/'
  else
    @next()

Router.onBeforeAction checkUserLoggedIn, except: [
  'index',
  'leaderboard',
  'profile'
]

